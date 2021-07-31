//
//  RegistrationViewController.swift
//  emSphere
//  Created by Dhiraj Chaudhari on 06/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit
import DropDown

class RegistrationViewController: UIViewController {

    //MARK:- Properties
    fileprivate let registrationTypeDropDown = DropDown()
    var employeeCode = ""
    var mobileNo = ""
    var companyCode = ""
    var registrationType = ""

    //MARK: - IBOutlets
    @IBOutlet var empCodeTextField: BCFloatingTextfield!
    @IBOutlet var mobiNoTextField: BCFloatingTextfield!
    @IBOutlet var companyCodeTextField: BCFloatingTextfield!
    @IBOutlet var registrationTypeTextField: BCFloatingTextfield!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var accountButton: UIButton!


    //MARK:- viewController Delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.isHidden = true
        self.setupAllTextField()
        self.setupDropDown()
        self.setupFontForIpad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submitButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (submitButton.frame.size.height/2), height: (submitButton.frame.size.height/2)))
    }

    func setupFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
        self.submitButton.set(fontSize: 18)
        self.accountButton.set(fontSize: 18)
        }
    }

    func setupAllTextField() {
        self.empCodeTextField.setupTheme("Employee Code")
        self.mobiNoTextField.keyboardType = .numberPad
        self.mobiNoTextField.setupTheme("Mobile Number")
        self.companyCodeTextField.setupTheme("Company Code")
        self.registrationTypeTextField.setupTheme("Registration Type")
        self.registrationTypeTextField.setRightView(#imageLiteral(resourceName: "downArrow"))
        self.registrationTypeDropDown.anchorView = self.registrationTypeTextField
    }

    func setupDropDown() {
        registrationTypeDropDown.backgroundColor = #colorLiteral(red: 0.2125797272, green: 0.2368075252, blue: 0.3497058153, alpha: 1)
        registrationTypeDropDown.selectionBackgroundColor = UIColor.lightGray
        registrationTypeDropDown.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        registrationTypeDropDown.dismissMode = .automatic
        registrationTypeDropDown.dataSource = ["New", "Mobile Change/Format", "Uninstalled"]
        registrationTypeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.registrationTypeTextField.text = item
        }

    }

    func setLoginView(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        appDelegate.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
        appDelegate.window?.makeKeyAndVisible()
    }

    //MARK: Functions and Related callbacks
    func validate() -> Bool {
        if empCodeTextField.text == "" {
            self.empCodeTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter employee code.")
            return true
        } else if mobiNoTextField.text == "" {
           mobiNoTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter mobile number.")
            return true
        } else if mobiNoTextField.text?.count != 10 {
             mobiNoTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Mobile number should be 10 digit.")
            return true
        } else if companyCodeTextField.text == "" {
            companyCodeTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter company code.")
            return true
        } else if registrationTypeTextField.text == "" {
            registrationTypeTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please select registration type.")
            return true
        }
        return false
    }

    func setupHomeScreen() {
       
    }

    //register api call
    func registerApiCall() {
        var url = Const.appUrl.licenseUrl
        
        let endPoint = "/Registration"
        if (self.empCodeTextField.text == "Apple001" && self.mobiNoTextField.text == "7506254979" && self.companyCodeTextField.text == "testing"){
          //  url = "http://emcloud.emsphere.com/Enterprise_MobileApp_Testing/app/"
        }
        
        
        /*
        if (self.empCodeTextField.text == "Demo01" && self.mobiNoTextField.text == "7506254979"){
            let dict:[String:String] = ["employeeCode":"Demo01","companyCode":"comp1"]
            UserProfile.saveRegistrationDetails(userInfo: dict)
            // http://125.99.69.58/Enterprise_MobileApp/app/Api/
            //http://125.99.69.58/Enterprise_MobileApp/app/Api//EmployeeApi/UserLogin?userName=yogesh168&password=sa&deviceId=ABCDE-12345&employeeCode=Demo01
         //   UserProfile.saveServiceURL(url: "http://125.99.69.58/Enterprise_MobileApp/app/Api/")
         //   UserProfile.saveUDID(status: "ABCDE-12345")
        }*/
        
         var dicParameters: [String:String]?
        dicParameters = ["employeeCode": self.empCodeTextField.text ?? "", "mobileNumber": self.mobiNoTextField.text ?? "", "companyCode": self.companyCodeTextField.text ?? "", "registrationType":self.registrationTypeTextField.text ?? "","deviceID":Const.uniqueDeviceUUID]
        
        let dataModel = DataModel(employeeCode: self.empCodeTextField.text, mobileNumber: self.mobiNoTextField.text, companyCode: self.companyCodeTextField.text, registrationType: self.registrationTypeTextField.text, deviceID:(Const.uniqueDeviceUUID))

        print("UUID=\(Const.uniqueDeviceUUID)")
        let parameters = dataModel.toJSON()

        url = url + endPoint
        print(" register url = \(url)")
        //Business type api call
        self.view.showLoading()
        APIManager.register(param: dicParameters!, url: url) { status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                if (response!.value(forKey: "status") == nil){
                    self.view.showErrorMessage(message: response?.value(forKey:"Message") as! String)
                    return
                }

                let statusValue = response!.value(forKey: "status") as? String

                if statusValue == "1" {
                    print("registration Responce=",response!)

                    let dict:[String:String] = ["employeeCode":self.empCodeTextField.text! ,"companyCode":self.companyCodeTextField.text!]
                     UserProfile.saveRegistrationDetails(userInfo: dict)
                    self.view.showSuccessMessage(message: response?.value(forKey: "message") as! String)
                     if (self.empCodeTextField.text == "Demo01" && self.mobiNoTextField.text == "7506254979"){
                        self.setLoginView()
                     } else {
                        //jump to license key screen need to implement.
                        let licenseKeyView = UIStoryboard.Main().instantiateViewController(withIdentifier: "LicenseKeyViewController") as! LicenseKeyViewController

                        if ((response!.value(forKey: "data")) != nil){
                            licenseKeyView.emailId =  (response!.value(forKey: "data")as? String)!
                        }

                        self.present(licenseKeyView, animated: true, completion: nil)
                       // self.navigationController?.pushViewController(licenseKeyView, animated: true)
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
                print(error! as APIError)
                self.view.showErrorMessage(message: error!.errorDescription)
            }
        }
    }

    //MARK: Functions and Related callbacks
    @IBAction func registerAction(_ sender: UIButton) {
        if validate() {
            return
        }
        self.registerApiCall()
    }
    
    @IBAction func showLoginView(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popToRootViewController(animated: true)

            if (UserProfile.getIsAllowLoginUsingOTP() == "1") {
                UserProfile.saveIsLogoutByOTP(status: "1")
                let otpView = UIStoryboard.Main().instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                self.present(otpView, animated: true, completion: nil)
                //self.navigationController?.pushViewController(otpView, animated: true)
            } else{
                //let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let window = UIApplication.shared.windows.first
                let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
                window?.makeKeyAndVisible()
            }
    }

}

//MARK:- UITextFieldDelegate methods
extension RegistrationViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == registrationTypeTextField {
            self.registrationTypeDropDown.show()
            return false
        }
        return true
    }

    func textFieldShouldEndEditing(_ textldField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

