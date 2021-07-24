//
//  LoginViewController.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 06/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps

class LoginViewController: UIViewController {
    
    //MARK:- Properties
    var loginDetails: [String: Any]? = nil
    var isOTP = "0"
    var userName:String?
    var isExecuted = false
    //MARK: - IBOutlets
    @IBOutlet var emailTextField: ACFloatingTextfield!
    @IBOutlet var passwordTextField: ACFloatingTextfield!
    @IBOutlet var remeberMeBtn: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var remeberMeButton: UIButton!
    @IBOutlet var registerNewUserButn: UIButton!
    @IBOutlet weak var forgotPasswordButn: UIButton!
    //MARK:- viewController Delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginDetails = UserProfile.getRemeberMe()
        
        self.setupView()
        self.setFontForIpad()
        
        let regiDic = UserProfile.getRegistrationDetails()
        print("regiDic = ", regiDic)
        
        print("Udid = ",Const.uniqueDeviceUUID)
        
        print("FcmToken =",Const.deviceToken)
        print("UserProfile.getIsAllowLoginUsingOTP=",UserProfile.getIsAllowLoginUsingOTP)
        let otp = UserProfile.getIsAllowLoginUsingOTP()
        self.didsetupNavigationBar()
        // print("otp=",otp)
        if (UserProfile.getIsAllowLoginUsingOTP() == "1"){
            if(UserProfile.getIsLogoutByOTP() == "1"){
              
            }
            passwordTextField.setupTheme("Enter OTP")
            self.registerNewUserButn.setTitle("Don't Have OTP", for: .normal)
            passwordTextField.isSecureTextEntry = false
            self.remeberMeBtn.isHidden = true
            self.remeberMeButton.isHidden = true
            self.forgotPasswordButn.isHidden = true
        }else {
           
            passwordTextField.isSecureTextEntry = true
            self.registerNewUserButn.setTitle("Register New User", for: .normal)
            self.remeberMeBtn.isHidden = false
            self.remeberMeButton.isHidden = false
        }
        
        if ((regiDic) != nil && UserProfile.isVisitToLocationVC() != nil && UserProfile.isVisitToLocationVC() != false){
            if !(LocationManager.sharedInstance.enableLocationService()){
                self.showLocationServiceAlert()
            }
        }
      //  self.syncOfflineAttedanceData() //MARK:commnted on 30-05-2021 given sync button in those controller
        
        
        //MARK:code on 08-05-2021 if locaion permistion enable then start location service
        if LocationManager.sharedInstance.enableLocationService(){
            LocationManager.sharedInstance.startUpdatingLocation()
        }
        /*
         let otpView = UIStoryboard.Main().instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
         self.present(otpView, animated: true, completion: nil) */
    }
    
    //MARK:code 08-05-2021 for setup navigation bar  in view did load it crashesh for some device
    private func didsetupNavigationBar(){
        if let naviBar = self.navigationController{
            // NavigationBarUtils.setTransperentNavigationBar(navigationController:self.navigationController!)
            NavigationBarUtils.setTransperentNavigationBar(navigationController:naviBar)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (loginButton.frame.size.height/2), height: (loginButton.frame.size.height/2)))
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("UserProfile.getIsAllowLoginUsingOTP=",UserProfile.getIsAllowLoginUsingOTP)
        if ((UserProfile.getIsAllowLoginUsingOTP()) == "1"){
            passwordTextField.setupTheme("Enter OTP")
            self.remeberMeBtn.isHidden = true
            self.remeberMeButton.isHidden = true
        }else {
            //NavigationBarUtils.setTransperentNavigationBar(navigationController:self.navigationController!)
            self.remeberMeBtn.isHidden = false
            self.remeberMeButton.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isExecuted == false {
            isExecuted = true
            self.didsetupNavigationBar() //MARK:code 08-05-2021 in view did load it crashesh for some device
        }
    }
    
    func setFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.remeberMeBtn.set(fontSize: 18)
            self.loginButton.set(fontSize: 18)
            self.registerNewUserButn.set(fontSize: 18)
        }
        
    }
    //MARK: Functions and Related callbacks
    func setupView() {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            // emailTextField.font = emailTextField.font?.withSize(22)
            // passwordTextField.font = passwordTextField.font?.withSize(22)
        }
        // forgotPasswordButn.isHidden = false
        emailTextField.setupTheme("Username")
        emailTextField.isContainLeftIcon = true
        passwordTextField.isContainLeftIcon = true
        passwordTextField.setupTheme("Password")
        emailTextField.setLeftView(#imageLiteral(resourceName: "icon_user"))
        passwordTextField.setLeftView(#imageLiteral(resourceName: "icon_password"))
        passwordTextField.isSecureTextEntry = true
        remeberMeButton.setImage(#imageLiteral(resourceName: "unchecked-unfilled"), for: .selected)
        
        if let uName = userName{
            let trimmedName = uName.trimmingCharacters(in: .whitespaces)
            emailTextField.text = trimmedName //MARK:set username which is passed from otp screen
        }
        
        guard let loginData = loginDetails else {
            print("Empty loginDetails")
            return
        }
        if (UserProfile.getIsAllowLoginUsingOTP() == "0" || UserProfile.getIsAllowLoginUsingOTP() == nil){
            emailTextField.text = loginData["email"] as? String
            passwordTextField.text = loginData["password"] as? String
            remeberMeButton.isSelected = true
            remeberMeButton.setImage(#imageLiteral(resourceName: "checkbox-filled"), for: .selected)
        }
        
        
    }
    
    func setupHomeScreen() {
        /*
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let mainViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let leftViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let nvc: UINavigationController = NavigationBarUtils.setupNavigationController(viewController: mainViewController)
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        appDelegate.window?.rootViewController = slideMenuController
        
        appDelegate.window?.makeKeyAndVisible()
        */
        
    }
    
    func validate() -> Bool {
        
        var userName = ""
        
        if let data = UserProfile.getUserProfile(){
            userName = data["EmployeeCode"]!
            print("userName=",userName)
        }
        if emailTextField.text == "" {
            emailTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter username.")
            return true
        }else if passwordTextField.text == ""{
            passwordTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter password.")
            return true
        }else if ((passwordTextField.text == "") && (UserProfile.getIsAllowLoginUsingOTP() == "1")){
            passwordTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter OTP.")
            return true
        }/*else if((emailTextField.text != userName) && (UserProfile.getIsAllowLoginUsingOTP() == "1")) {
         emailTextField.showErrorWithText(errorText: "")
         self.view.showErrorMessage(message: "Invalid Username or OTP.")
         return true
         }else if ((emailTextField.text != userName) && (UserProfile.getIsAllowLoginUsingOTP() == "0")){
         emailTextField.showErrorWithText(errorText: "")
         self.view.showErrorMessage(message: "Invalid Username or Password.")
         return true
         } */
        
        return false
    }
    func setMobileConfurationData(dicArray:[NSDictionary]?){
        
        for dic in dicArray! {
            if(dic["Key"]as!String == "HideLeaveApp"){
                UserProfile.saveIsHideLeaveApp(status:dic["Value"]as?String )
            }
            if(dic.value(forKey: "Key")as!String == "HideCompOffApp"){
                UserProfile.saveIsHideCompOffApp(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideRegularizationApp"){
                UserProfile.saveIsHideRegularizationApp(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideWFHApp"){
                UserProfile
                    .saveIsHideWFHApp(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideOutDutyApp"){
                UserProfile.saveIsHideOutDutyApp(status:dic.value(forKey: "Value")as?String )
            }
            if(dic.value(forKey: "Key")as!String == "HideMarkAttendance"){
                UserProfile.saveIshideMarkAttendance(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "Remark"){
                UserProfile.saveIsRemark(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "AllowLoginUsingOTP"){
                UserProfile.saveIsAllowLoginUsingOTP(status:dic.value(forKey: "Value")as?String)
                print("AllowLoginUsingOTP value =",dic.value(forKey: "Value")as?String)
                print("AllowLoginUsingOTP=",UserProfile.getIsAllowLoginUsingOTP())
            }
            if(dic.value(forKey: "Key")as!String == "SendOTPThroughSMS"){
                UserProfile.saveIsSendOTPThroughSMS(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "SendOTPThroughEmail"){
                UserProfile.saveIsSendOTPThroughEmail(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideCameraForMarkAttendance"){
                UserProfile.saveIsHideCameraForMarkAttendance(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideShiftAllocation"){
                UserProfile.saveIsHideShiftAllocation(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideAttendanceDetails"){
                UserProfile.saveIsHideAttendanceDetails(status: dic.value(forKey: "Value")as?String)
            }
            if(dic.value(forKey: "Key")as!String == "HideApplicationStatus"){
                UserProfile.saveIsHideApplicationStatus(status: dic.value(forKey: "Value")as?String)
            }
            
            if(dic.value(forKey: "Key")as!String == "HideDiscrepancies"){
                UserProfile.saveIsHideDiscrepancies(status: dic.value(forKey: "Value")as?String)
            }
            
        }
    }
    /*
     func setMobileConfurationData(dicArray:[NSDictionary]?){
     
     for dic in dicArray! {
     if(dic["Key"]as!String == "HideLeaveApp"){
     UserProfile.saveIsHideLeaveApp(status:dic["Value"]as?String )
     }
     if(dic.value(forKey: "Key")as!String == "HideCompOffApp"){
     UserProfile.saveIsHideCompOffApp(status: dic.value(forKey: "Value")as?String)
     }
     if(dic.value(forKey: "Key")as!String == "HideRegularizationApp"){
     UserProfile.saveIsHideRegularizationApp(status: dic.value(forKey: "Value")as?String)
     }
     if(dic.value(forKey: "Key")as!String == "HideWFHApp"){
     UserProfile
     .saveIsHideWFHApp(status: dic.value(forKey: "Value")as?String)
     }
     if(dic.value(forKey: "Key")as!String == "HideOutDutyApp"){
     UserProfile.saveIsHideOutDutyApp(status:dic.value(forKey: "Value")as?String )
     }
     if(dic.value(forKey: "Key")as!String == "HideMarkAttendance"){
     UserProfile.saveIshideMarkAttendance(status: dic.value(forKey: "Value")as?String)
     }
     if(dic.value(forKey: "Key")as!String == "Remark"){
     UserProfile.saveIsRemark(status: dic.value(forKey: "Value")as?String)
     }
     }
     }
     */
    func showLocationServiceAlert() {
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
    
    func getAddress(lat: String, _ long: String, currentAdd : @escaping ( _ returnAddress :String)->Void){
        
        let geocoder = GMSGeocoder()
        //let coordinate = CLLocationCoordinate2DMake(Double(locationManager.lastLocation!.coordinate.latitude),Double(locationManager.lastLocation!.coordinate.longitude))
        print("lat =\(lat),long =\(long)")
        
        let lattitude = Double(lat)
        let longitude = Double(long)
        
        print("lattitude=\(lattitude),longitude=\(longitude)")
        
        let coordinate = CLLocationCoordinate2DMake(lattitude!,longitude!)
        
        var currentAddress = String()
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if ((error) != nil) {
                
                self.view.dissmissLoading()
                self.presentAlert(withTitle: "", message: "Soory, unable to address")
                //self.showAlert(message: "Soory, unable to address")
                return
            }
            // print("responce of GMSGeocoder=",response?.results())
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
                currentAddress = lines.joined(separator: "\n")
                currentAddress = currentAddress + ", \(address.country!)"
                currentAddress = currentAddress.replace(target: "\\n", withString: ",")
                currentAdd(currentAddress)
            }
        }
    }
    
    func syncOfflineAttedanceData() {
        if (UserProfile.getUserProfile() != nil) {
            let offlineMarkAttendanceArray = DataBaseHandler.shared.getOfflineAttendanceMarkData(query:"Select * from OfflineAttendanceMark")
            
            for markObj in offlineMarkAttendanceArray{
                let obj = markObj as? MarkAttendanceInfo
                print("Old blank address=",obj?.locationAddress)
                self.getAddress(lat:(obj?.latitude)! , (obj?.longitude)!, currentAdd: {  (returnAddress) in
                    print("new Address = \(returnAddress)")
                    
                    obj?.locationAddress = returnAddress
                    self.view.dissmissLoading()
                    self.markAttandaceOfflineDataSyncApiCall(markAttedanceInfo: markObj as!MarkAttendanceInfo)
                })
                
            }
        } // end of if
        
    }
    
    
    // getDictinary from info object
    func getParameterDictionaryFromInfoObject(attedanceInfo:MarkAttendanceInfo)-> [String:String] {
        var parameterDic = [String:String]()
        
        let registrationDetails = UserProfile.getUserProfile()
        let employeeId = registrationDetails!["EmployeeID"]!
        print("attedanceInfo.locationAddress=",attedanceInfo.locationAddress)
        print("employee id =",employeeId)
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
    
    func saveIsloginByOTP(){
        UserProfile.saveIsLogin(status: "1")
    }
    
    // loginWith url api
    func loginWithUrlApiCall() {
        UserProfile.clearIsloginByOTP()
        
        // Here is Static code for Apple user
        var parameters: [String:String]?
        var url = ""
        /*
         if (emailTextField.text == "yogesh168" && passwordTextField.text == "sa") {
         url = "http://125.99.69.58/Enterprise_MobileApp/app/Api/EmployeeApi/UserLogin"
         let dict:[String:String] = ["employeeCode":"Demo01","companyCode":"comp1"]
         UserProfile.saveRegistrationDetails(userInfo: dict)
         // http://125.99.69.58/Enterprise_MobileApp/app/Api/
         //http://125.99.69.58/Enterprise_MobileApp/app/Api//EmployeeApi/UserLogin?userName=yogesh168&password=sa&deviceId=ABCDE-12345&employeeCode=Demo01
         let appUrl = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app"
         let endPoint = "Api/EmployeeApi/UserLogin"
         UserProfile.saveServiceURL(url: "http://125.99.69.58/Enterprise_MobileApp/app/Api/")
         UserProfile.saveUDID(status: "ABCDE-12345")
         parameters = ["userName": emailTextField.text!, "password": passwordTextField.text!, "deviceId": "ABCDE-12345", "employeeCode": "Demo01"]
         }else {
         */
        if ((UserProfile.getServiceURL()) == nil) {
            self.presentAlert(withTitle: "", message: "Please register yourself.")
            return
        }
        //url = UserProfile.getServiceURL()! + "/EmployeeApi/UserLogin"
        url = UserProfile.getServiceURL()! + Const.appUrl.employeeApi + "UserLogin"
        UserProfile.clearIsloginByOTP()
        let registrationDetails = UserProfile.getUserProfile()
        let empCode = registrationDetails!["EmployeeCode"]!
        let username = emailTextField.text ?? ""
        let uName = username.trimmingCharacters(in: .whitespaces)
        let emCode = empCode.trimmingCharacters(in: .whitespaces)
        parameters = ["userName": uName, "password": passwordTextField.text!, "deviceId": Const.uniqueDeviceUUID, "employeeCode": emCode]
        // }
        
        self.view.showLoading()
        APIManager.loginWithUrl(param:parameters! , url: url){ status, response, error in
            
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
                    return
                }
                
                let statusValue = response!.value(forKey: "status") as? String
                print("statusValue:\(String(describing: statusValue))")
                
                if statusValue == "1" {
                    print("login responce = ",response!)
                    let responceArray = response?.value(forKey: "data")as?[NSDictionary]
                    let username = self.emailTextField.text
                    UserProfile.saveUserName(username: username) //MARK:chnaged on 18-03-2021
                    //save token for login
                    for dic in responceArray!{
                        if (dic.value(forKey: "Key")as!String == "Token"){
                            let token = dic.value(forKey: "Value")as!String
                            UserProfile.saveLoginToken(token: token)
                            print("get token =",UserProfile.getLoginToken()!)
                            
                        }
                        if(dic.value(forKey: "Key")as!String == "IsManager"){
                            Const.isManager = dic.value(forKey: "Value")as!String
                            UserProfile.saveIsManager(status: "1")
                            print("isManager from user default = ",UserProfile.getIsManager() as Any)
                            print("isManager = ",Const.isManager)
                        }
                    }
                    
                    //jump to home
                    //self.getMobileApplicationConfiguration()
                    //self.saveIslogin()
                    
                    // Here is Static code for Apple user
                    UserProfile.saveIsLogoutByOTP(status: "0")
                    if(self.emailTextField.text == "yogesh168" && self.passwordTextField.text == "sa") {
                        //self.licenseVerificationApiCall()
                        self.staticUserData()
                    } else {
                        self.setupHomeScreen()
                    }
                    
                } else if statusValue == "0" {
                    print(response!)
                    
                    let error = response?.value(forKey: APIResponceKey.message.rawValue) as! String
                    let message = error.replace(target: "\\r\\n", withString: ".")
                    
                    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }  else if error != nil {
                //api failure
                self.view.dissmissLoading()
                let err = error! as APIError
                print("code =\(err.errorCodeInt) and hoo = \(err.errorCode)")
                print(error! as APIError)
                self.view.showErrorMessage(message: error!.errorDescription)
            }
        }
    }
    
    //login api call
    func loginWithOTPApiCall() {
        UserProfile.clearIsloginByOTP()
        let registrationDetails = UserProfile.getUserProfile()
        let empCode = registrationDetails!["EmployeeCode"]!
        // for mail optValue is 1 and for sms is 0
        var otpValue = "0"
        if (UserProfile.getIsSendOTPThroughEmail() == "1"){
            otpValue = "1"
        } else {
            otpValue = "0"
        }
        
        let dataModel = DataModel(userName:emailTextField.text!, OTP: self.passwordTextField.text, deviceId: Const.uniqueDeviceUUID, employeeCode: empCode)
        
        let parameters = dataModel.toJSON()
        
        self.view.showLoading()
        APIManager.userLoginWithOTP(param: parameters) { status, response, error in
            
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
                    return
                }
                
                let statusValue = response!.value(forKey: "status") as? String
                print("statusValue:\(String(describing: statusValue))")
                
                if statusValue == "1" {
                    print("login responce = ",response!)
                    let responceArray = response?.value(forKey: "data")as?[NSDictionary]
                    let username = self.emailTextField.text
                    UserProfile.saveUserName(username: username) //MARK:chnaged on 18-03-2021
                    //save token for login
                    for dic in responceArray!{
                        if (dic.value(forKey: "Key")as!String == "Token"){
                            let token = dic.value(forKey: "Value")as!String
                            UserProfile.saveLoginToken(token: token)
                            print("get token =",UserProfile.getLoginToken()!)
                            
                        }
                        if(dic.value(forKey: "Key")as!String == "IsManager"){
                            let isManager = dic.value(forKey: "Value")as? String ?? ""
                            UserProfile.saveIsManager(status: isManager)
                            print("isManager from user default = ",UserProfile.getIsManager())
                            print("isManager = ",Const.isManager)
                        }
                        
                    }
                    
                    //jump to home
                    // self.getMobileApplicationConfiguration()
                    self.saveIsloginByOTP()
                    UserProfile.saveIsLogoutByOTP(status: "0")
                    self.setupHomeScreen()
                    
                } else if statusValue == "0" {
                    print(response!)
                    
                    let error = response?.value(forKey: APIResponceKey.message.rawValue) as? String ?? ""
                    let message = error.replace(target: "\\r\\n", withString: ".")
                    
                    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }  else if error != nil {
                //api failure
                self.view.dissmissLoading()
                print("eroor = ",error! as APIError)
                
                self.view.showErrorMessage(message: error!.errorDescription)
            }
        }
    }
    
    
    // MobileApplicationConfiguration
    func  getMobileApplicationConfigurationLoginApi() {
        self.view.showLoading()
        APIManager.getMobileApplicationConfiguration(completion: { status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as? String ?? "")
                    print("eror when status is nil=",response?.value(forKey:"Message")as? String ?? "")
                    return
                }
                let statusValue = response!.value(forKey: "status") as? String
                if statusValue == "1" {
                    print("MobileApplicationConfiguration responce = ",response!)
                    let dicArray = response?.value(forKey: "data")as? [NSDictionary]
                    self.setMobileConfurationData(dicArray: dicArray)
                    self.setupHomeScreen()
                } else if statusValue == "0" {
                    print(response!)
                }
            }   else if error != nil {
                //api failure
                self.view.dissmissLoading()
                print(error! as APIError)
                DispatchQueue.main.async {
                    self.view.showErrorMessage(message: error!.errorDescription)
                    print("error when status is not  nil=",response?.value(forKey:"Message") as? String ?? "")
                }
            }
        })
    }
    
    // offline markAttandaceOffline Api call
    func markAttandaceOfflineDataSyncApiCall(markAttedanceInfo:MarkAttendanceInfo) {
        
        let url = UserProfile.getServiceURL()! + Const.appUrl.employeeApi + "AddMobileSwipes"
        
        let parameters = self.getParameterDictionaryFromInfoObject(attedanceInfo: markAttedanceInfo)
        self.view.showLoading()
        APIManager.uploadImageForMarkAttendanceData(param:parameters , url: url){ status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    
                    self.view.showErrorMessage(message: response?.value(forKey:"Message")as? String ?? "")
                    print("eror when status is nil=",response?.value(forKey:"Message") as? String ?? "")
                    return
                }
                let statusValue = response!.value(forKey: "status") as? String
                if statusValue == "1" {
                    print("mark attedace  responce = ",response ?? "")
                    self.didUpdateHistoryStatus(markId: markAttedanceInfo.id)
                    let deleted = DataBaseHandler.shared.deleteData(query: "delete from OfflineAttendanceMark where id=\(markAttedanceInfo.id)")
                    
                    print("deleted =",deleted)
                    
                } else if statusValue == "0" {
                    print(response ?? "")
                    self.view.showErrorMessage(message: response?.value(forKey: APIResponceKey.message.rawValue) as? String ?? "")
                }
            }   else if error != nil {
                //api failure
                self.view.dissmissLoading()
                print(error! as APIError)
                DispatchQueue.main.async {
                    self.view.showErrorMessage(message: error!.errorDescription)
                    print("error when status is not  nil=",response?.value(forKey:"Message") as? String ?? "")
                }
            }
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
    func staticUserData(){
        
        let empIdNum = "5479"
        let empId = "5479"
        let gender = "M"
        let designationName = "Associate Business Analyst-500"
        let fName = "Emsphere"
        let lName = "App"
        let name = fName + " " + lName
        let emailId = "emsphereapp@gmail.com"
        let birthDate = "06 Jul 1988"
        let branchCode = "Hyderabad / ValueLabs Technologies-II"
        let categoryName = "Full Time Employee /U2013 FTE"
        let departmentName = "QA"
        let empCode = "Demo01"
        //let isallowEmail = empDic?.value(forKey: "AllowEmail")as?Int
        let allowEmail = "1"
        // print("isallowEmail =\(isallowEmail) and allowEmail = \(allowEmail)")
        
        print("branchCode",branchCode)
        print("empCode",empCode)
        let dict:[String:String] = ["EmployeeID":empId ,"Full Name":name,"OfficalEmailID":emailId,"Gender":gender,"DesignationName":designationName,"BirthDate":birthDate,"Branch":branchCode,"Category":categoryName,"Department":departmentName,"EmployeeCode":empCode,"AllowEmail":allowEmail]
        
        UserProfile.saveUserProfile(userInfo: dict)
        if let data = UserProfile.getUserProfile(){
            print("UserProfile data=\(data)")
        }
        
        self.getMobileApplicationConfiguration()
        
    }
    
    /*
     //license verification api call
     func licenseVerificationApiCall() {
     // check key for dic for below code
     
     let dataModel = DataModel(employeeCode: "Demo01", deviceId:"ABCDE-12345", licenseNumber: "11111", companyCode: "comp1", FCMID: Const.deviceToken)
     let parameters = dataModel.toJSON()
     
     //Business type api call
     self.view.showLoading()
     APIManager.verifyLicenseNumber(param: parameters) { status, response, error in
     
     if status == true {
     self.view.dissmissLoading()
     //api success // status code = 200
     let statusValue = response!.value(forKey: "status") as? String
     print("statusValue:\(String(describing: statusValue))")
     if !((statusValue) != nil){
     
     self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
     return
     }
     if statusValue == "1" {
     print("license verification responce = ",response!)
     // let url = response?.value(forKey: "serviceUrl")as?String
     //UserProfile.saveServiceURL(url: url)
     // print("ServiceUrl=",UserProfile.getServiceURL())
     //let userData = response?.value(forKey: "data")
     
     let dic = response?.value(forKey: "data") as? NSDictionary
     
     // print("dic=",dic)
     let empDic = dic?.value(forKey: "Employee") as?NSDictionary
     //  print("empDic=",empDic)
     let empIdNum = empDic?.value(forKey: "EmployeeID")as?NSNumber
     let empId = empIdNum?.stringValue
     let gender = empDic?.value(forKey: "Gender")as!String
     let designationName = dic?.value(forKey: "DesignationName") as!String
     let fName = empDic?.value(forKey: "FirstName")as?String
     let lName = empDic?.value(forKey: "LastName") as?String
     let name = fName! + " " + lName!
     let emailId = empDic?.value(forKey: "OfficalEmailID") as? String
     let birthDate = empDic?.value(forKey: "BirthDate") as!String
     let branchCode = dic?.value(forKey: "BranchCode") as!String
     let categoryName = dic?.value(forKey: "CategoryName") as!String
     let departmentName = dic?.value(forKey: "DepartmentName") as!String
     let empCode = empDic?.value(forKey: "EmployeeCode") as!String
     let isallowEmail = empDic?.value(forKey: "AllowEmail")as?Int
     let allowEmail = String(isallowEmail!)
     print("isallowEmail =\(isallowEmail) and allowEmail = \(allowEmail)")
     
     print("branchCode",branchCode)
     print("empCode",empCode)
     let dict:[String:String] = ["EmployeeID":empId! ,"Full Name":name,"OfficalEmailID":emailId!,"Gender":gender,"DesignationName":designationName,"BirthDate":birthDate,"Branch":branchCode,"Category":categoryName,"Department":departmentName,"EmployeeCode":empCode,"AllowEmail":allowEmail]
     
     UserProfile.saveUserProfile(userInfo: dict)
     let data = UserProfile.getUserProfile()
     
     UserDefaults.standard.set(true, forKey: "isRegistered")
     //print("User Data=",data)
     let namedata = data!["Full Name"]
     print("namedata=",namedata)
     
     self.view.showSuccessMessage(message: response?.value(forKey: APIResponceKey.message.rawValue) as! String)
     
     self.getMobileApplicationConfiguration()
     
     } else if statusValue == "0" {
     print(response!)
     DispatchQueue.main.async {
     let error = response?.value(forKey: APIResponceKey.message.rawValue) as! String
     let message = error.replace(target: "\\r\\n", withString: ".")
     self.presentAlert(withTitle: "", message: message)
     // self.showAlert(message: message)
     }
     }
     }  else if error != nil {
     //api failure
     self.view.dissmissLoading()
     print(error! as APIError)
     DispatchQueue.main.async {
     self.view.showErrorMessage(message: error!.errorDescription)
     }
     }
     }
     }
     */
    
    // MobileApplicationConfiguration
    func  getMobileApplicationConfiguration() {
        self.view.showLoading()
        APIManager.getMobileApplicationConfiguration(completion: { status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil) {
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
                    print("eror when status is nil=",response?.value(forKey:"Message") as! String)
                    return
                }
                
                let statusValue = response!.value(forKey: "status") as? String
                if statusValue == "1" {
                    
                    print("MobileApplicationConfiguration responce = ",response!)
                    let dicArray = response?.value(forKey: "data")as? [NSDictionary]
                    self.setMobileConfurationData(dicArray: dicArray)
                    
                    // self.setupLoginType()
                    self.setupHomeScreen()
                } else if statusValue == "0" {
                    print(response!)
                }
            }   else if error != nil {
                //api failure
                self.view.dissmissLoading()
                print(error! as APIError)
                DispatchQueue.main.async {
                    self.view.showErrorMessage(message: error!.errorDescription)
                    print("error when status is not  nil=",response?.value(forKey:"Message") as! String)
                }
            }
        })
    }
    
    
    //MARK: IBActions
    @IBAction func loginAction(_ sender: UIButton) {
        
        if !validate() {
            if remeberMeButton.isSelected {
                let loginDetails: [String: Any] = ["email": emailTextField.text!, "password": passwordTextField.text!]
                print(loginDetails)
                UserProfile.saveRememberMe(userInfo: loginDetails)
            } else {
                if UserDefaults.standard.value(forKey: "LOGIN_DATA") != nil {
                    UserDefaults.standard.removeObject(forKey: "LOGIN_DATA")
                }
                UserDefaults.standard.synchronize()
            }
            
            // Here is Static code for Apple user
            // if (emailTextField.text == "yogesh168" && passwordTextField.text == "sa") {
            if (emailTextField.text == "admin" && passwordTextField.text == "sa") {
                self.loginWithUrlApiCall()
            } else {
                let defaults = UserDefaults.standard
                defaults.bool(forKey: "isRegistered")
                
                if (defaults.bool(forKey: "isRegistered")){
                    if (UserProfile.getIsAllowLoginUsingOTP() == "1") {
                        self.loginWithOTPApiCall()
                    } else {
                        //self.loginWithPasswordApiCall()
                        self.loginWithUrlApiCall()
                    }
                }else{
                    self.view.showErrorMessage(message: "Please register first.")
                }
            }
            
        }
        
    }
    
    @IBAction func didTappedForgotPasswordButn(_ sender: Any) {
        self.showForgotPasswordPopUp()
    }
    
    
    @IBAction func remeberMeAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            remeberMeButton.isSelected = false
            remeberMeButton.setImage(#imageLiteral(resourceName: "unchecked-unfilled"), for: .normal)
        } else {
            sender.isSelected = true
            remeberMeButton.isSelected = true
            remeberMeButton.setImage(#imageLiteral(resourceName: "checkbox-filled"), for: .selected)
        }
    }
    
    @IBAction func showRegisterView(_ sender: UIButton) {
        if (self.registerNewUserButn.titleLabel?.text == "Don't Have OTP"){
            let otpView = UIStoryboard.Main().instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            self.present(otpView, animated: true, completion: nil)
        } else {
            let registrationView = UIStoryboard.Main().instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
            self.present(registrationView, animated: true, completion: nil)
        }
    }
    
}

extension LoginViewController:ForgotPasswordAlertDelegate{
    func didShowMessgae(msg: String) {
        self.presentAlert(withTitle: "", message: msg)
    }
    
    func showForgotPasswordPopUp() {
        let forgotPasswordView = UIStoryboard.CustomPopup().instantiateViewController(withIdentifier: "ForgotPasswordPoppuVC")as!ForgotPasswordPoppuVC
        forgotPasswordView.modalPresentationStyle = .overCurrentContext
        forgotPasswordView.modalTransitionStyle = .crossDissolve
        forgotPasswordView.alertDelegate = self
        self.present(forgotPasswordView, animated:true, completion:nil)
    }
    
}
