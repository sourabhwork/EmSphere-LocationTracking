//
//  LicenseKeyViewController.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 14/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class LicenseKeyViewController: UIViewController {
    
    //MARK:- Properties
    var emailId = ""
    
    //MARK: - IBOutlets
    @IBOutlet var licenseKeyTextField: BCFloatingTextfield!
    @IBOutlet var registerButton: UIButton!
    
    @IBOutlet var mailInfoLabel: UILabel!
    @IBOutlet var enterLicenceLabel: UILabel!
    @IBOutlet var didntReceviedLabel: UIButton!
    @IBOutlet var spamLabel: UILabel!
    
    @IBOutlet var licenseKeyTfWidthConstraint: NSLayoutConstraint!
    @IBOutlet var reisterButnWidthConstraint: NSLayoutConstraint!
    @IBOutlet var verticalSpaceBetnTfAndButn: NSLayoutConstraint!
    @IBOutlet var verticalSpaceBetnLogoAndTf: NSLayoutConstraint!
    
    //MARK:- viewController Delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.isHidden = true
        
        let str1 = "Access code has been sent to your E-mail id "
        let str2 = "\""
        let str3 = self.emailId
        let str4 = ", Please enter the same here to register"
        
        
        let attributedString1 = NSMutableAttributedString(string: str1)
        attributedString1.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9633457065, green: 0.6807981133, blue: 0.2581744492, alpha: 1), range: NSRange(location: 0, length: str1.count))
        
        let attributedString2 = NSMutableAttributedString(string: str2)
        attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9633457065, green: 0.6807981133, blue: 0.2581744492, alpha: 1), range: NSRange(location: 0, length: str2.count))
        
        let attributedString3 = NSMutableAttributedString(string: str3)
        attributedString3.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.8209624887, green: 0.8209818602, blue: 0.8209714293, alpha: 1), range: NSRange(location: 0, length: str3.count))
        
        let attributedString4 = NSMutableAttributedString(string: str4)
        attributedString4.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9633457065, green: 0.6807981133, blue: 0.2581744492, alpha: 1), range: NSRange(location: 0, length: str4.count))
        
        let attributedMutableStr = NSMutableAttributedString()
        attributedMutableStr.append(attributedString1)
        attributedMutableStr.append(attributedString2)
        attributedMutableStr.append(attributedString3)
        attributedMutableStr.append(attributedString2)
        attributedMutableStr.append(attributedString4)
        
        self.mailInfoLabel.attributedText = attributedMutableStr
        
        self.setupView()
        self.setFontForIpad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (registerButton.frame.size.height/2), height: (registerButton.frame.size.height/2)))
    }
    
    //MARK: Functions and Related callbacks
    func setupView() {
        licenseKeyTextField.setupTheme("Access Code")
    }
    
    func setFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.mailInfoLabel.font = self.mailInfoLabel.font.withSize(18)
            self.enterLicenceLabel.font = self.enterLicenceLabel.font.withSize(18)
            self.spamLabel.font = self.spamLabel.font.withSize(18)
            self.didntReceviedLabel.set(fontSize: 18)
            self.registerButton.set(fontSize: 18)
        }
        
    }
    
    func validate() -> Bool {
        if licenseKeyTextField.text == "" {
            licenseKeyTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter access code.")
            return true
        }
        return false
    }
    
    func showAlert(message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setMobileConfurationData(dicArray:[NSDictionary]?){
        print("conf dicArray =\(dicArray)")
        for dic in dicArray ?? [] {
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
    
    func setupLoginType(){
        print("setupLoginType func is called")
        UserProfile.clearIsloginByOTP()
        UserProfile.clearIsManager()
        
        // if LoginUsingOTP == 1 and if 0 then using local password
        if (UserProfile.getIsAllowLoginUsingOTP() == "1"){
            // here is code for OTP functionality
            let otpView = UIStoryboard.Main().instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            self.present(otpView, animated: true, completion: nil)
            //self.navigationController?.pushViewController(otpView, animated: true)
            
        } else {
           // let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let window = UIApplication.shared.windows.first
            window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
            window?.makeKeyAndVisible()
            /*
             let loginView = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
             self.present(loginView, animated: true, completion: nil) */
        }
    }
    
    func didSaveDataForLicence(){
        let empIdNum = "846"
        let empId = "846"
        let gender = "M"
        let designationName = " ASSISTANT MANAGER SPARES"
        let fName = "Apple"
        let lName = "Testing"
        let name = fName + " " + lName
        let emailId = "emsphere.tester@gmail.com"
        let birthDate = " 02-Jan-2001"
        let branchCode = "KOLKATTA"
        let categoryName = "Dealer"
        let departmentName = "Sales"
        let empCode = " Apple001"
        //let isallowEmail = empDic?.value(forKey: "AllowEmail")as?Int
        let allowEmail = "1"
        let dict:[String:String] = ["EmployeeID":empId ,"Full Name":name,"OfficalEmailID":emailId,"Gender":gender,"DesignationName":designationName,"BirthDate":birthDate,"Branch":branchCode,"Category":categoryName,"Department":departmentName,"EmployeeCode":empCode,"AllowEmail":allowEmail]
        UserProfile.saveUserProfile(userInfo: dict)
        let data = UserProfile.getUserProfile()
        let serviceUrl = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/api/"
        
        UserProfile.saveServiceURL(url: serviceUrl)
        UserDefaults.standard.set(true, forKey: "isRegistered")
    }
    //license verification api call
    func licenseVerificationApiCall() {
        // check key for dic for below code
        
        let regiDic = UserProfile.getRegistrationDetails()
        let employeeCode =  regiDic!["employeeCode"] //as?String //"1008"
        let companyCode = regiDic!["companyCode"] //as?String  //"comp1"
        
        // print("employeeCode=",employeeCode)
        //  print("companyCode=",companyCode)
        // 8761436181304359
        var licenceKey = licenseKeyTextField.text ?? ""
        licenceKey = licenceKey.trimmingCharacters(in: .whitespaces)
        let dataModel = DataModel(employeeCode: employeeCode, deviceId:Const.uniqueDeviceUUID, licenseNumber: licenceKey, companyCode: companyCode, FCMID: Const.deviceToken)
        let parameters = dataModel.toJSON()
        
        var url = Const.appUrl.licenseUrl
        let endPoint = "/VerifyLicenseNumber"
        
        url = url + endPoint
        print("licenseVerification url = \(url)")
        //Business type api call
        
        
        self.view.showLoading()
        
        if employeeCode == "Apple001" && companyCode == "testing" && licenceKey == "5992003405328566" {
            self.didSaveDataForLicence()
            self.view.dissmissLoading()
            self.view.showSuccessMessage(message: "License registerd successfully!!!")
            self.getMobileApplicationConfiguration()
            //  self.setupLoginType()
            return
        }
        APIManager.verifyLicenseNumber(param: parameters, url: url) { status, response, error in
            
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
                    let url = response?.value(forKey: "serviceUrl")as?String
                    UserProfile.saveServiceURL(url: url)
                    // print("ServiceUrl=",UserProfile.getServiceURL())
                    //let userData = response?.value(forKey: "data")
                    
                    let dic = response?.value(forKey: "data") as? NSDictionary
                    
                    // print("dic=",dic)
                    let empDic = dic?.value(forKey: "Employee") as?NSDictionary
                    //  print("empDic=",empDic)
                    let empIdNum = empDic?.value(forKey: "EmployeeID")as?NSNumber
                    let empId = empIdNum?.stringValue ?? ""
                    let gender = empDic?.value(forKey: "Gender")as? String ?? ""
                    let designationName = dic?.value(forKey: "DesignationName") as!String
                    let fName = empDic?.value(forKey: "FirstName")as?String ?? ""
                    let lName = empDic?.value(forKey: "LastName") as?String ?? ""
                    let name = fName + " " + lName
                    let emailId = empDic?.value(forKey: "OfficalEmailID") as? String ?? ""
                    let birthDate = empDic?.value(forKey: "BirthDate") as?String ?? ""
                    let branchCode = dic?.value(forKey: "BranchCode") as? String ?? ""
                    let categoryName = dic?.value(forKey: "CategoryName") as?String ?? ""
                    let departmentName = dic?.value(forKey: "DepartmentName") as?String ?? ""
                    let empCode = empDic?.value(forKey: "EmployeeCode") as?String ?? ""
                    let isallowEmail = empDic?.value(forKey: "AllowEmail")as?Int
                    let allowEmail = String(isallowEmail!)
                    print("isallowEmail =\(isallowEmail) and allowEmail = \(allowEmail)")
                    
                    print("branchCode=",branchCode)
                    print("empCode=",empCode)
                    let dict:[String:String] = ["EmployeeID":empId ,"Full Name":name,"OfficalEmailID":emailId,"Gender":gender,"DesignationName":designationName,"BirthDate":birthDate,"Branch":branchCode,"Category":categoryName,"Department":departmentName,"EmployeeCode":empCode,"AllowEmail":allowEmail]
                    
                    UserProfile.saveUserProfile(userInfo: dict)
                    if let data = UserProfile.getUserProfile(){
                        let namedata = data["Full Name"]
                        print("namedata=",namedata)
                    }
                    UserDefaults.standard.set(true, forKey: "isRegistered")
                    //print("User Data=",data)
                    
                    
                    self.view.showSuccessMessage(message: response?.value(forKey: APIResponceKey.message.rawValue) as! String)
                    /*
                     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                     self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)
                     } */
                    self.getMobileApplicationConfiguration() 
                    
                } else if statusValue == "0" {
                    print(response)
                    DispatchQueue.main.async {
                        let error = response?.value(forKey: APIResponceKey.message.rawValue) as? String ?? ""
                        let message = error.replace(target: "\\r\\n", withString: ".")
                        self.showAlert(message: message)
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
    
    
    // MobileApplicationConfiguration
    func  getMobileApplicationConfiguration() {
        self.view.showLoading()
        APIManager.getMobileApplicationConfiguration(completion: { status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil) {
                    let msg =  response?.value(forKey:"Message") as? String ?? ""
                    self.view.showErrorMessage(message:msg)
                    print("eror when status is nil=",msg)
                    return
                }
                
                let statusValue = response!.value(forKey: "status") as? String
                if statusValue == "1" {
                    
                    print("MobileApplicationConfiguration responce = ",response ?? "")
                    let dicArray = response?.value(forKey: "data")as? [NSDictionary]
                  //  self.setMobileConfurationData(dicArray: dicArray)
                    UtilityManager.didSaveConfiguartionData(dicArray:dicArray)
                    
                    self.setupLoginType()
                    //self.setupHomeScreen()
                } else if statusValue == "0" {
                    print(response ?? "")
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
    
    //MARK: IBActions
    @IBAction func register(_ sender: UIButton) {
        
        if !validate() {
            // do your code
            self.licenseVerificationApiCall()
            
        }
    }
    
    @IBAction func didntRecieveButnAction(_ sender: UIButton) {
        
        
    }
    
    
} // end Of Vc
