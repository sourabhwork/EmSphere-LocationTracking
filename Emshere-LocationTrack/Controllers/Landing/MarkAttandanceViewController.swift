//
//  MarkAttandanceViewController.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 13/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//
// show last punch with in out status // 11/06/018
import UIKit
import AVFoundation
import Alamofire
import CoreLocation
import GoogleMaps
import MapKit
import DropDown
import SwiftLocation

class MarkAttandanceViewController: UIViewController {
    
    //MARK:- Properties
    var timer: Timer?
    var isCollasable = false
    var noOfCell = 0
    var door = "1"
    var currentAddress = ""
    var employeeId = ""
    var locationManager = LocationManager.sharedInstance
    
    
    var captureDevice: AVCaptureDevice?
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var stillImageOutput: AVCaptureStillImageOutput?
    var capturedPhoto: UIImage? = nil //
    
    var offlineMarkAttendanceArray = NSMutableArray()
    var punchHistoryArray = NSMutableArray()
    var homeTabArray = [String]()
    var offlineMarkAttendanceArrayCount:Int = 0
    
    //MARK: - IBOutlets
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var inPunchButton: UIButton!
    @IBOutlet var outPunchButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var lastPunchLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var backgroundMapView: UIView!
    //@IBOutlet var homeTabCollectionView: UICollectionView!
    //UICollectionView!
    @IBOutlet var footerViewHeightConstaint: NSLayoutConstraint!
    @IBOutlet var punchInButnHeightConstraint: NSLayoutConstraint!
    
    fileprivate let dropDown    = DropDown()
    fileprivate var bgTimer     = Timer()
    
    //MARK:- viewController Delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // commented for second build
            //#colorLiteral(red: 0.3745557666, green: 0.3901350498, blue: 0.4719911814, alpha: 1)
        //#colorLiteral(red: 0.2125797272, green: 0.2368075252, blue: 0.3497058153, alpha: 1)
//        if !(locationManager.enableLocationService()){
//            self.showLocationServiceAlert()
//        }
//        if SwiftLocation.authorizationStatus == .denied || SwiftLocation.authorizationStatus == .restricted || SwiftLocation.authorizationStatus == .notDetermined {
//            self.showLocationServiceAlert()
//        }
        lastPunchLabel.text = ""
        //locationManager.startUpdatingLocation()
        self.setNavigationBar()
        
        let registrationDetails = UserProfile.getUserProfile()
        employeeId = registrationDetails!["EmployeeID"]!
        print("employee id =",employeeId)
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            self.footerViewHeightConstaint.constant = 60
            self.view.layoutIfNeeded()
        }
        
        tableView.isHidden = true
        self.lastPunchLabel.isHidden = true
        self.setHomeTabApplicatonArray()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "GetLocation"), object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.showCurrentLocationOnMapview),name: Notification.Name(rawValue: "GetLocation"),object: nil)
        
        //MARK:Here limit chnaged to 10 ,old one is 5 code on 18-March-2021
        
        //  punchHistoryArray = DataBaseHandler.shared.getPunchHistoryData(query: "Select * from MarkAttendanceHistory order by id desc limit 5")
        punchHistoryArray = DataBaseHandler.shared.getPunchHistoryData(query: "Select * from MarkAttendanceHistory order by id desc limit 10")
        
        if (punchHistoryArray.count > 0) {
            let punchObj = punchHistoryArray[0] as!MarkAttendanceInfo
            let date = "\(punchObj.markDate) \(punchObj.markTime)"
            self.setLastPunchAttribuedString(date:date, inOutStatus: punchObj.markStatus)
        }
        
        self.deletePunchHistory()
        //self.removePreviousControler()
        //self.setupCamera()
        //self.setCameraLayout()
        
        UserProfile.saveIsVisitToLocationVC(status: true)
        // self.syncOfflineData()
        
    }
    
    func setCameraLayout() {
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        inPunchButton.makeCircular(width: 1, color: .white)
        outPunchButton.makeCircular(width: 1, color: .white)
        self.profileImageView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        
//        if let flowLayout = self.homeTabCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            let theWidth = self.homeTabCollectionView.frame.size.width / CGFloat(self.homeTabArray.count)
//            let theHeight = self.homeTabCollectionView.frame.size.height
//            if (UIDevice.current.userInterfaceIdiom == .pad){
//                self.punchInButnHeightConstraint.constant = 100
//                print("Collection View Width for ipad =",theWidth)
//                flowLayout.itemSize = CGSize(width:theWidth , height: theHeight)
//            } else if (self.homeTabArray.count < 4) {
//                print("Collection View Width for iphone=",theWidth)
//                flowLayout.itemSize = CGSize(width:theWidth , height: theHeight)
//            }
//        }// end of if flowlayout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create code by sourabh 26-7-2021
        if !SwiftLocationManager.getIsAuthorization() {
            self.showLocationServiceAlert()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
        self.setHomeTabApplicatonArray()
        
        // Set timer for location tracking
        if !bgTimer.isValid {
            self.bgTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
            RunLoop.main.add(bgTimer, forMode: .common)
            RunLoop.current.run()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
        
    }
    
    @objc func timerUpdate() {
        print("$$$$$$$$$$$$$  Timer update $$$$$$$$$$$$$$$$$$$$")
        let lastLocation = SwiftLocationManager.lastKnownLocation().coordinate
        print("Last location is ",lastLocation)
        let address = SwiftLocationManager.getAddress(location: lastLocation)
        print("Last Location address",address)
    }
    
    func setLastPunchAttribuedString(date:String,inOutStatus:String) {
        
        let str1 = "Last Punch  "
        
        let str2 = date + " " + inOutStatus
        
        let attributedString1 = NSMutableAttributedString(string: str1)
        attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), range: NSRange(location: 0, length: str1.count))
        
        let textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let attributedString2 = NSMutableAttributedString(string: str2)
        attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: str2.count))
        
        let attributedMutableStr = NSMutableAttributedString()
        attributedMutableStr.append(attributedString1)
        attributedMutableStr.append(attributedString2)
        
        self.lastPunchLabel.attributedText = attributedMutableStr
    }
    
    /*
     func enableLocationService() {
     let status = CLLocationManager.authorizationStatus()
     switch status {
     case .restricted, .denied:
     // Disable your app's location features
     print("location service is off denied,restricted")
     self.showLocationServiceAlert()
     break
     case .notDetermined:
     print("location service is off notDetermined")
     case .authorizedAlways:
     print("location service is off authorizedAlways")
     case .authorizedWhenInUse:
     print("location service is off authorizedWhenInUse")
     }
     
     } */
    
    
    @objc func showCurrentLocationOnMapview() {
        
        //set current address to marker pin
        self.view.showLoading()
        self.getAddress() {
            (returnAddress) in
            print("new Address = \(returnAddress)")
            self.currentAddress = returnAddress
            self.view.dissmissLoading()
        }
    }
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2125797272, green: 0.2368075252, blue: 0.3497058153, alpha: 1)
                    
        navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 1
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationController?.navigationBar.layer.shadowRadius = 0
                
        self.title = "Mark Attandance"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
//        let backImageButton = UIButton(type: .custom)
//        backImageButton.frame = CGRect(x: 0, y: 9, width: 25, height: 25)
//        backImageButton.setBackgroundImage(#imageLiteral(resourceName: "ic_action_toolbarleft_arrow"), for: .normal)
//        backImageButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        let logoImage = UIImageView(frame: CGRect(x: 33, y: 9, width: 30, height: 30))
        logoImage.image = UIImage(named: "em_logo_small.png")
        logoImage.contentMode = .scaleAspectFit
       // view.addSubview(backImageButton)
        view.addSubview(logoImage)
        let logo = UIBarButtonItem(customView: view)
        logo.action = #selector(back)
        self.navigationItem.setLeftBarButtonItems([logo], animated:true )
        
        let dotsButton = UIButton(type: .custom)
         //MARK:LocationUpdate in tracking  code on 25-07-2021
        dotsButton.setBackgroundImage(UIImage(named: "ic-vertical-dots"), for: .normal)
        dotsButton.addTarget(self, action: #selector(navigateToChangePasswordVc), for: .touchUpInside)
        let notificationBarButton = UIBarButtonItem(customView: dotsButton)
        notificationBarButton.setBadge(text: Const.notificationBadgeCount)
        dropDown.anchorView = notificationBarButton
        //  let synchBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_action_sync"), style: .done, target: self, action: #selector(syncData))
        navigationItem.setRightBarButtonItems([notificationBarButton], animated: true)
    }
    
    func setHomeTabApplicatonArray() {
        
        var homeApplnArray = [String]()
        var calenderlnArray = [String]()
        if (UserProfile.getIsHideLeaveApp() == "0") {
            homeApplnArray.append("Leave\nApplication")
            calenderlnArray.append("Leave Application")
        }
        if (UserProfile.getIsHideRegularizationApp() == "0") {
            homeApplnArray.append("Attendence\nRegularization")
            calenderlnArray.append("Attendence Regularization")
        }
        if (UserProfile.getIsHideOutDutyApp() == "0") {
            homeApplnArray.append("Out Duty\nApplication")
            calenderlnArray.append("Out Duty Application")
        }
        if (UserProfile.getIsHideCompOffApp() == "0") {
            homeApplnArray.append("Comp-Off\nApplication")
            calenderlnArray.append("Comp-Off Application")
        }
        if (UserProfile.getIsHideWFHApp() == "0") {
            homeApplnArray.append("WFH\nApplication")
            calenderlnArray.append("WFH Application")
        }
        let dic = ["HomeApplnArray":homeApplnArray,"CalnderApplnArray":calenderlnArray]
        
        UserProfile.saveApplicationArrayDic(applicationArrayDic: dic)
        let dic1 = UserProfile.getApplicationArrayDic()
        //print("dic1",dic1)
        self.homeTabArray = dic1!["HomeApplnArray"]!
//        if(self.homeTabArray.count == 0){
//            self.homeTabCollectionView.backgroundColor = UIColor.clear
//        }else {
//            self.homeTabCollectionView.backgroundColor = UIColor.white
//        }
        
        //self.setupHomeTabLayout()
        self.viewDidLayoutSubviews()
        //self.homeTabCollectionView.reloadData()
    }
    
    func getAttenadnceInfo(remarkStr:String){
        var remark = ""
        if (UserProfile.getIsRemark() == "0") {
            remark = remarkStr
        }
        let lat = "\(String(describing: locationManager.lastLocation!.coordinate.latitude))"
        let lng = "\(String(describing: locationManager.lastLocation!.coordinate.longitude))"
        var inOutStatus = ""
        if (door == "1"){
            inOutStatus = "IN"
        } else {
            inOutStatus = "OUT"
        }
        self.lastPunchLabel.isHidden = true
        self.setLastPunchAttribuedString(date: Date().toString(format: .shiftDate), inOutStatus: inOutStatus)
        // lastPunchLabel.text = "Last Punch : " + Date().toString(format: .shiftDate) + " " + inOutStatus
        
        print("lattitude=",lat)
        print("longitude =",lng)
        print("currentAddress=",currentAddress)
        
        //let image = self.profileImageView.image
        let image = self.capturedPhoto?.imageRotatedByDegrees(degrees: 90, flip: false)
        
        if((image) != nil){
            print("image is not nil")
        } else {
            print("image is  nil")
        }
        
        let imageData = image!.jpegData(compressionQuality: 0.5)
        let encodedImageData = (imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)))!
        // changed by dhiraj for map  15-June-018
        
        if Connectivity.isConnectedToInternet() {
            let parameters: [String:String] = ["swipeTime": Date().toString(format: .shiftDate), "latitude": lat, "longitude": lng, "locationAddress": currentAddress,  "isOnlineSwipe": "True", "remark": remark, "locationProvider":"GPS","door":door,"deviceId":Const.uniqueDeviceUUID,"employeeId":employeeId,"swipeImageFileName": encodedImageData]
            self.markAttandaceApiCall(remark: remark, parameter: parameters)
            
        } else {
            let parameters: [String:String] = ["swipeTime": Date().toString(format: .shiftDate), "latitude": lat, "longitude": lng, "locationAddress": currentAddress,  "isOnlineSwipe": "False", "remark": remark, "locationProvider":"GPS","door":door,"deviceId":Const.uniqueDeviceUUID,"employeeId":employeeId,"swipeImageFileName": encodedImageData]
            //_ = self.insertOfflineAttendanceMarkData(remark: remark)
            let inserted = self.insertOfflineAttendanceMarkData(remark: remark, parameter:parameters, isOffline: true )
            print("inserted =",inserted)
            
        }
        
    } // end ogf get info func
        
    func showAlert(message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLocationServiceAlert() {
        self.locationManager.locationManager?.requestAlwaysAuthorization()
        let settingsButton = NSLocalizedString("OK", comment: "")
        let message = NSLocalizedString("Your need to enable location services.", comment: "")
        let goToSettingsAlert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        
        goToSettingsAlert.addAction(UIAlertAction(title: settingsButton, style: .default, handler: { (action: UIAlertAction) in
            DispatchQueue.main.async {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    } else {
                        UIApplication.shared.openURL(settingsUrl as URL)
                    }
                }
            }
        }))
        
        self.present(goToSettingsAlert, animated: true, completion: nil)
        
    }
    
    // bar button item function call
    @objc func back(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func removePreviousControler() {
        
        if var viewControllers = self.navigationController?.viewControllers {
            for vc in viewControllers {
                if vc.isKind(of: MarkAttedanceMapViewController.classForCoder()) {
                    print("It is in stack")
                    //Your Process
                    let index = viewControllers.index(of: vc)
                    print("Index of ViewController Map Vc =",index)
                    viewControllers.remove(at: index!)
                    self.navigationController?.viewControllers = viewControllers
                }
            }
        }
    }
    
    @objc func navigateToChangePasswordVc() {
        dropDown.dataSource = ["Change Password"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            let changePaswordView = UIStoryboard.Main().instantiateViewController(withIdentifier: "ChangePasswordViewController")as!ChangePasswordViewController
             self.navigationController?.pushViewController(changePaswordView, animated: true)
        }
        dropDown.width = 200.0
        dropDown.show()
//       let changePaswordView = UIStoryboard.Main().instantiateViewController(withIdentifier: "ChangePasswordViewController")as!ChangePasswordViewController
//        self.navigationController?.pushViewController(changePaswordView, animated: true)
    }
    
    @objc func syncData() {
        ///*
        self.view.showLoading()
        APIManager.getSyncMobileApplicationConfiguration { (result) in
            print("result=",result)
            if (result){
                self.view.showSuccessMessage(message: "Success")
                self.setHomeTabApplicatonArray()
                print("UserProfile.getIshideMarkAttendance() =",UserProfile.getIshideMarkAttendance())
                if(UserProfile.getIshideMarkAttendance() == "1") {
                    print("Enter in MapView condn")
                    let markAttandance1 = UIStoryboard.Home().instantiateViewController(withIdentifier: "MarkAttedanceMapViewController") as! MarkAttedanceMapViewController
                    self.navigationController?.pushViewController(markAttandance1, animated: true)
                    self.removePreviousControler()
                }
            }
            self.view.dissmissLoading()
        } //*/
        /*
         if (UserProfile.getIshideMarkAttendance() == "1"){
         UserProfile.saveIshideMarkAttendance(status: "0")
         } else {
         UserProfile.saveIshideMarkAttendance(status: "1")
         } */
        
        //self.viewDidLoad()
    }
    
    //MARK: Functions and Related callbacks
    /* func setupCamera() {
     
     var captureDevice: AVCaptureDevice?
     
     if #available(iOS 10.2, *) {
     captureDevice = AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .front)
     } else {
     // Fallback on earlier versions
     captureDevice = AVCaptureDevice.default(for: .video)
     captureDevice = (AVCaptureDevice.devices()
     .filter{ $0.hasMediaType(AVMediaType.video) && $0.position == .front})
     .first
     }
     
     do {
     let input = try AVCaptureDeviceInput(device: captureDevice!)
     captureSession = AVCaptureSession()
     captureSession?.addInput(input)
     
     videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
     videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
     videoPreviewLayer?.frame = profileImageView.layer.bounds
     profileImageView.layer.addSublayer(videoPreviewLayer!)
     
     
     } catch {
     print(error)
     }
     
     captureSession?.startRunning()
     } */
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSession.Preset.photo
        captureDevice = AVCaptureDevice.default(for: .video)
        captureDevice = (AVCaptureDevice.devices()
            .filter{ $0.hasMediaType(AVMediaType.video) && $0.position == .front})
            .first
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: captureDevice!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput!) {
                captureSession!.addOutput(stillImageOutput!)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                videoPreviewLayer?.frame = profileImageView.layer.bounds
                profileImageView.layer.addSublayer(videoPreviewLayer!)
            }
        }
        captureSession!.startRunning()
    }
    
    @objc func updateDate() {
        self.dateLabel.text = Date().toString(format: .punchDate)
    }
    
    func deletePunchHistory() {
        //  if (punchHistoryArray.count > 5) { //MARK:chnaged on 20-March-2021
        if (punchHistoryArray.count > 10) {
            for (index, item) in punchHistoryArray.enumerated() {
                print("Found \(item) at position \(index)")
                let punchObj = item as!MarkAttendanceInfo
                //  if (index > 4) { //MARK:chnaged on 20-March-2021
                if (index > 9) {
                    let deleted = DataBaseHandler.shared.deleteData(query: "delete from MarkAttendanceHistory where id=\(punchObj.id)")
                    
                    print("deleted =",deleted)
                }
            }
        }
    }
    
    func insertOfflineAttendanceMarkData(remark: String,parameter:[String:String],isOffline:Bool) -> Bool{
        
        let parameters = parameter
        var attedanceInfo = self.getInfoObjectFromDictionary(parameterDic: parameters)
        var status = ""
        if (door == "1") {
            status = "IN"
        } else{
            status = "OUT"
        }
        
        attedanceInfo.markAttendanceEmpId = employeeId
        attedanceInfo.markDate = Date().toString(format: .birthday)
        attedanceInfo.markTime =  Date().toString(format: .TwelveHourtime)
        attedanceInfo.markStatus = status
        
        print("attedanceInfo.markDate=",attedanceInfo.markDate)
        print("attedanceInfo.markTime=",attedanceInfo.markTime)
        
        if isOffline {
            
            let result2 = DataBaseHandler.shared.addMarkAttendanceData(attedanceInfo)
            print("insertTable result2=",result2)
            //MARK:code on 04-03-2021
            if result2 == true{
                let query = "SELECT * FROM OfflineAttendanceMark ORDER BY id DESC LIMIT 1"
                let array = DataBaseHandler.shared.getOfflineAttendanceMarkData(query:query)
                if let lastInserted = array.firstObject as? MarkAttendanceInfo{
                    attedanceInfo.id =  lastInserted.id
                }
            }
            /*
             offlineMarkAttendanceArray = DataBaseHandler.shared.getOfflineAttendanceMarkData(query:"Select * from OfflineAttendanceMark order by id desc")
             
             print("offlineMarkAttendanceArray count",offlineMarkAttendanceArray.count)
             
             let obj = offlineMarkAttendanceArray[0] as!MarkAttendanceInfo
             print("mark remark",obj.remark)
             let id = obj.id
             print("id",id) */
        }
        let result = DataBaseHandler.shared.addMarkAttendanceHistryData(attedanceInfo)
        print("insertTable result=",result)
        //MARK:Here limit chnaged to 10 ,old one is 5 code on 18-March-2021
        //  punchHistoryArray = DataBaseHandler.shared.getPunchHistoryData(query: "Select * from MarkAttendanceHistory order by id desc limit 5")
        self.didGetPuncHistory()
        
        return true
    }
    
    func didGetPuncHistory(){
        punchHistoryArray = DataBaseHandler.shared.getPunchHistoryData(query: "Select * from MarkAttendanceHistory order by id desc limit 10")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getInfoObjectFromDictionary(parameterDic:[String:String])-> MarkAttendanceInfo {
        let attedanceInfo = MarkAttendanceInfo()
        attedanceInfo.employeeId = employeeId
        attedanceInfo.deviceId = Const.uniqueDeviceUUID
        attedanceInfo.swipeTime = parameterDic["swipeTime"]!
        attedanceInfo.latitude = parameterDic["latitude"]!
        attedanceInfo.longitude = parameterDic["longitude"]!
        attedanceInfo.locationAddress = parameterDic["locationAddress"]!
        attedanceInfo.swipeImageFileName = parameterDic["swipeImageFileName"]!
        attedanceInfo.isOnlineSwipe = parameterDic["isOnlineSwipe"]!
        attedanceInfo.remark = parameterDic["remark"]!
        attedanceInfo.locationProvider = parameterDic["locationProvider"]!
        attedanceInfo.door = parameterDic["door"]!
        return attedanceInfo
    }
    
    // getDictinary fron info object
    func getParameterDictionaryFromInfoObject(attedanceInfo:MarkAttendanceInfo)-> [String:String] {
        var parameterDic = [String:String]()
        
        parameterDic["employeeId"] = employeeId
        parameterDic["deviceId"] =  Const.uniqueDeviceUUID
        parameterDic["swipeTime"] = attedanceInfo.swipeTime
        parameterDic["latitude"] = attedanceInfo.latitude
        parameterDic["longitude"] =  attedanceInfo.longitude
        parameterDic["locationAddress"] =  attedanceInfo.locationAddress
        parameterDic["swipeImageFileName"] = attedanceInfo.swipeImageFileName
        parameterDic["isOnlineSwipe"] = attedanceInfo.isOnlineSwipe
        parameterDic["remark"] = attedanceInfo.remark
        parameterDic["locationProvider"] = attedanceInfo.locationProvider
        parameterDic["door"] = attedanceInfo.door
        
        return parameterDic
    }
    
    func syncOfflineData() {
        /*
         offlineMarkAttendanceArray = DataBaseHandler.shared.getOfflineAttendanceMarkData(query:"Select * from OfflineAttendanceMark")
         
         for markObj in offlineMarkAttendanceArray{
         self.markAttandaceOfflineDataSyncApiCall(markAttedanceInfo: markObj as!MarkAttendanceInfo, syncObjectNum: 0)
         }*/
        
        offlineMarkAttendanceArray = DataBaseHandler.shared.getOfflineAttendanceMarkData(query:"Select * from OfflineAttendanceMark")
        //MARK:old code
        self.offlineMarkAttendanceArrayCount = offlineMarkAttendanceArray.count
        /*
         for markObj in offlineMarkAttendanceArray{
         self.markAttandaceOfflineDataSyncApiCall(markAttedanceInfo: markObj as!MarkAttendanceInfo)
         }*/
        
        //MARK:New code
        if offlineMarkAttendanceArray.count == 0{
            self.view.showErrorMessage(message: "Sorry no data to sync.")
        }else{
            self.didSyncOfflineIndiual()
        }
    }
    
    func didSyncOfflineIndiual(){
        if let markAtt = offlineMarkAttendanceArray.firstObject as? MarkAttendanceInfo{
            //MARK:code on 04-03-2021
            self.markAttandaceOfflineDataSyncApiCall(markAttedanceInfo: markAtt,syncObjectNum: 0)
        }
        
        
    }
    
    
    func didUpdateHistoryStatus(markId:String){
        if markId == ""{
            return
        }
        /*
         UPDATE employees
         SET city = 'Toronto',
         state = 'ON',
         postalcode = 'M5P 2N7'
         WHERE
         employeeid = 4;*/
        let updatedStatus = "1"
        let updateQuery = "UPDATE MarkAttendanceHistory set serverSyncStatus = \(updatedStatus) where attendanceId =\(markId)"
        let updateResult = DataBaseHandler.shared.updateData(query:updateQuery)
        
        print("updateResult = \(updateResult)")
    }
    // Api call
    // for uplaod image with mark attedace details
    func markAttandaceApiCall(remark: String,parameter:[String:String]) {
        
        var parameters = parameter
        
        // let url = UserProfile.getServiceURL()! + "/EmployeeApi/AddMobileSwipes"
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApi + "AddMobileSwipes"
        self.view.showLoading()
        APIManager.uploadImageForMarkAttendanceData(param:parameters , url: url){ status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
                    print("eror when status is nil=",response?.value(forKey:"Message") as! String)
                    return
                }
                let statusValue = response!.value(forKey: "status") as? String
                if statusValue == "1" {
                    print("mark attedace  responce = ",response!)
                    let inserted = self.insertOfflineAttendanceMarkData(remark: remark, parameter:parameters,isOffline: false)
                    print("inserted =",inserted)
                    self.showSuccessPopUp()
                    
                } else if statusValue == "0" {
                    print(response!)
                    if(response?.value(forKey: APIResponceKey.message.rawValue) as! String == "Your Session Expired"){
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "SessionExpire"), object: nil)
                    }  else{
                        let error = response?.value(forKey: APIResponceKey.message.rawValue) as! String
                        let message = error.replace(target: "\\r\\n", withString: ".")
                        self.showAlert(message: message)
                    }
                }
            }   else if error != nil {
                //api failure
                self.view.dissmissLoading()
                let err = error! as APIError
                print("errorCode = \(err.errorCode) and errorCodeInt = \(err.errorCodeInt)")
                
                if err.errorCodeInt == -1003 || !Connectivity.isConnectedToInternet() || err.errorCodeInt == -1009 || err.errorCodeInt == -1004 || err.errorCodeInt == -1001 || err.errorCodeInt == -1005{
                    
                    parameters["isOnlineSwipe"] = "False" //MARK:set isOnlineSwipe = False to save i datebase
                    let inserted = self.insertOfflineAttendanceMarkData(remark: remark, parameter:parameters, isOffline: true)
                    
                    print("inserted =",inserted)
                    self.showSuccessPopUp()
                    return
                }else{DispatchQueue.main.async {
                    self.view.showErrorMessage(message: error!.errorDescription)
                    print("error when status is not  nil=",response?.value(forKey:"Message") as? String ?? "")
                    }
                }
            }
        }
    }
    
    func markAttandaceOfflineDataSyncApiCall(markAttedanceInfo:MarkAttendanceInfo,syncObjectNum:Int) {
        
        // let url = "http://seedmanagement.cloudapp.net/Enterprise_MobileApp/app/Api/EmployeeApi/AddMobileSwipes"
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApi + "AddMobileSwipes"
        let parameters = self.getParameterDictionaryFromInfoObject(attedanceInfo: markAttedanceInfo)
        self.view.showLoading()
        APIManager.uploadImageForMarkAttendanceData(param:parameters , url: url){ status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
                    print("eror when status is nil=",response?.value(forKey:"Message") as! String)
                    return
                }
                let statusValue = response!.value(forKey: "status") as? String
                if statusValue == "1" {
                    print("mark attedace  responce = ",response!)
                    self.didUpdateHistoryStatus(markId: markAttedanceInfo.id)
                    let deleted = DataBaseHandler.shared.deleteData(query: "delete from OfflineAttendanceMark where id=\(markAttedanceInfo.id)")
                    
                    print("deleted =",deleted)
                    if self.offlineMarkAttendanceArray.count > 0{
                        self.offlineMarkAttendanceArray.removeObject(at: 0)
                        print("Removed updated offline attedence from array")
                    }
                    self.didGetPuncHistory()//MARK:code on 04-03-2021
                    self.didSyncOfflineIndiual()
                    
                } else if statusValue == "0" {
                    print(response!)
                    if(response?.value(forKey: APIResponceKey.message.rawValue) as! String == "Your Session Expired"){
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "SessionExpire"), object: nil)
                    } else{
                        self.view.showErrorMessage(message: response?.value(forKey: APIResponceKey.message.rawValue) as! String)
                    }
                }
            }   else if error != nil {
                //api failure
                self.view.dissmissLoading()
                print(error! as APIError)
                DispatchQueue.main.async {
                    self.view.showErrorMessage(message: error!.errorDescription)
                    
                    print("error when status is not  nil=",response?.value(forKey:"Message") as? String)
                }
            }
        }
    }
    
    //MARK: IBActions
    
    @IBAction func didTappedOfflineSyncButn(_ sender: Any) {
        self.syncOfflineData()
    }
    
    @IBAction func showTableViewRows(_ sender: UIButton) {
        if sender.isSelected {
            sender.transform = sender.transform.rotated(by: CGFloat(-(Double.pi / 2)))
            sender.isSelected = false
            isCollasable = false
            tableView.isHidden = true
            //self.homeTabCollectionView.isHidden = false
        } else {
            sender.transform = sender.transform.rotated(by: CGFloat( (Double.pi / 2)))
            sender.isSelected = true
            isCollasable = true
            //self.homeTabCollectionView.isHidden = true
            tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
    
    @IBAction func inPunchAction(_ sender: UIButton) {
        door = "1"
        self.takePhoto() // self.dummyTakePhoto() // capture image
        
        /*
         DispatchQueue.main.async {
         if (UserProfile.getIsRemark() == "0") {
         self.showRemarkPopUp()
         } else {
         self.getAttenadnceInfo(remarkStr: "")
         }
         } */
        
    }
    
    @IBAction func outPunchAction(_ sender: UIButton) {
        door = "2"
        self.takePhoto() // capture image
        
        /*
         if (UserProfile.getIsRemark() == "0") {
         showRemarkPopUp()
         } else {
         self.getAttenadnceInfo(remarkStr: "")
         } */
    }
    
    func showRemarkPopUp() {
        let remarkPopupView = UIStoryboard.CustomPopup().instantiateViewController(withIdentifier: "RemarkPopup")as!RemarkPopup
        
        remarkPopupView.modalPresentationStyle = .overCurrentContext
        remarkPopupView.modalTransitionStyle = .crossDissolve
        remarkPopupView.delegate = self
        self.present(remarkPopupView, animated:true, completion:nil)
    }
    
    func showSuccessPopUp() {
        let successPopupView = UIStoryboard.CustomPopup().instantiateViewController(withIdentifier: "MarkAttendanceSuccessPopup")as!MarkAttendanceSuccessPopup
        
        successPopupView.modalPresentationStyle = .overCurrentContext
        successPopupView.modalTransitionStyle = .crossDissolve
        successPopupView.date = self.dateLabel.text!
        var doorInOut = "IN"
        if (door == "2"){
            doorInOut = "OUT"
        }
        successPopupView.inOutStatus = doorInOut
        self.present(successPopupView, animated:true, completion:nil)
    }
    
    func takePhoto() {
        let videoConnection = stillImageOutput!.connection(with: .video)
        if(videoConnection != nil) {
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection!, completionHandler: { (sampleBuffer, error) -> Void in
                if sampleBuffer != nil {
                   
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider(data: imageData as! CFData)
                    let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.relativeColorimetric)
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImage.Orientation.right)
                   
                    self.capturedPhoto = image
                    
                    print("self.capturedPhoto",self.capturedPhoto)
                    if ((self.capturedPhoto) != nil){
                        print("self.capturedPhoto is not nil")
                    } else {
                        print("self.capturedPhoto is nil")
                    }
                    if (self.door == "1"){
                        if (UserProfile.getIsRemark() == "0") {
                            self.showRemarkPopUp()
                        } else {
                            self.getAttenadnceInfo(remarkStr: "")
                        }
                    } else {
                        
                        if (UserProfile.getIsRemark() == "0") {
                            self.showRemarkPopUp()
                        } else {
                            self.getAttenadnceInfo(remarkStr: "")
                        }
                    }
                } else{
                    print("sampleBuffer is nil")
                }
            })
        }
    }
        
    private func dummyTakePhoto(){
        self.capturedPhoto = #imageLiteral(resourceName: "attendance_through")
        print("self.capturedPhoto",self.capturedPhoto)
        if ((self.capturedPhoto) != nil){
            print("self.capturedPhoto is not nil")
        } else {
            print("self.capturedPhoto is nil")
        }
        if (self.door == "1"){
            if (UserProfile.getIsRemark() == "0") {
                self.showRemarkPopUp()
            } else {
                self.getAttenadnceInfo(remarkStr: "")
            }
        } else {
            
            if (UserProfile.getIsRemark() == "0") {
                self.showRemarkPopUp()
            } else {
                self.getAttenadnceInfo(remarkStr: "")
            }
        }
    }
    
    func getAddress(currentAdd : @escaping ( _ returnAddress :String)->Void){
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(locationManager.lastLocation!.coordinate.latitude),Double(locationManager.lastLocation!.coordinate.longitude))
        
        
        var currentAddress = String()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if ((error) != nil) {
                
                self.view.dissmissLoading()
                self.showAlert(message: "Sorry, unable to get address")
                return
            }
            // print("responce of GMSGeocoder=",response?.results())
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
                currentAddress = lines.joined(separator: "\n")
                currentAddress = currentAddress + ", \(address.country!)"
                print("currentAddress = \(currentAddress)")
                currentAdd(currentAddress)
            }
        }
    }
    
    func getAdressFromGoogleMap(){
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=AIzaSyB2-fEvPZvrhAc1KUpDubutLsVty3fsMJQ"
        Alamofire.request(url, method: .post, parameters:nil,encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print("Map RESPONCE =",response)
                
                break
            case .failure(let error):
                
                print("error =",error.localizedDescription)
            }
        }
    }
    
    func getLocationAddress(){
        
        if !Connectivity.isConnectedToInternet() {
            return
        }
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        
        center.latitude = locationManager.lastLocation!.coordinate.latitude
        center.longitude = locationManager.lastLocation!.coordinate.longitude
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var addressString : String = ""
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                //completionHandler(addressString,error)
                print("my address=",addressString)
                // self.currentAddress = addressString
            }
            
        })
        
    }
    
}  // end of vc

extension MarkAttandanceViewController: remarkDelegate {
    func getRemark(remark : String) {
        self.getAttenadnceInfo(remarkStr: remark)
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension MarkAttandanceViewController : AVCapturePhotoCaptureDelegate {
    @available(iOS 10.0, *)
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?) {
        //get captured image
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MarkAttandanceViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCollasable {
            if (section == 0) {
                return 1
            } else {
                return self.punchHistoryArray.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MarkAttandanceTableCell? = nil
        
        
        if (indexPath.section == 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: "MarkAttandanceTableTitleCell") as? MarkAttandanceTableCell
            if(UIDevice.current.userInterfaceIdiom == .pad){
                cell?.statusLabel.font = cell?.statusLabel.font.withSize(18)
                cell?.dateLabel.font = cell?.dateLabel.font.withSize(18)
                cell?.serverStatusLabel.font = cell?.serverStatusLabel.font.withSize(18)
            }
            cell?.statusLabel.text = "Date"
            cell?.dateLabel.text = "IN/OUT"//"Punch IN/OUT"
            cell?.serverStatusLabel.text = "Status"
            
        } else if (indexPath.section == 1){
            cell = tableView.dequeueReusableCell(withIdentifier: "MarkAttandanceTableCell") as? MarkAttandanceTableCell
            
            print("indexPath.row=",indexPath.row)
            let punchObj = punchHistoryArray[indexPath.row] as!MarkAttendanceInfo
            if(cell != nil) {
                if(UIDevice.current.userInterfaceIdiom == .pad){
                    cell?.statusLabel.font = cell?.statusLabel.font.withSize(18)
                    cell?.dateLabel.font = cell?.dateLabel.font.withSize(18)
                    cell?.serverStatusLabel.font = cell?.serverStatusLabel.font.withSize(18)
                }
                cell?.serverStatusImgView.image = nil
                cell?.statusLabel.text = "\(punchObj.markDate) \(punchObj.markTime)"//"01-Jan-1900 12:00 AM"
                cell?.dateLabel.text =  punchObj.markStatus //"IN"
                cell?.serverStatusLabel.text =  ""
                cell?.serverStatusImgView.image = punchObj.serverSyncStatus == "0" ? #imageLiteral(resourceName: "Right_Tick_Match"):#imageLiteral(resourceName: "doubleTick")
            }
        }
        
        cell?.selectionStyle = .none
        
        return cell!
    }
}

extension MarkAttandanceViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        var point = mapView.projection.point(for: marker.position)
        point.y = point.y + 200
        
        let newPoint = mapView.projection.coordinate(for: point)
        let camera123 = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera123)
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        marker.title = "title"
        marker.snippet = "kalpesh"
    }
    
}


//MARK: - Custom TableViewCell
class MarkAttandanceTableCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var serverStatusLabel: UILabel!
    @IBOutlet weak var serverStatusImgView: UIImageView!
    
    
    override func awakeFromNib() {
        // common design setup
        super.awakeFromNib()
    }
}

//// MARK:- UICollectionView Delegate and Datasource
//
//extension MarkAttandanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeTabCollectionViewCell
//        return cell
//    }
//}
