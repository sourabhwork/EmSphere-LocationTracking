//
//  OTPViewController.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 27/07/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OTPViewController: UIViewController {

    //MARK:- Properties
    var loginDetails: [String: Any]? = nil

    //MARK: - IBOutlets
    @IBOutlet var usernameTextField: ACFloatingTextfield!
    @IBOutlet var remeberMeBtn: UIButton!
    @IBOutlet var sendOtpButton: UIButton!
    @IBOutlet var remeberMeButton: UIButton!
    @IBOutlet var registerNewUser: UIButton!
    
    //MARK:- viewController Delegate methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.isHidden = true
        self.setupView()
        self.setFontForIpad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sendOtpButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (sendOtpButton.frame.size.height/2), height: (sendOtpButton.frame.size.height/2)))
    }

    //MARK: Functions and Related callbacks
    func setupView() {
        usernameTextField.setupTheme("Username")
        usernameTextField.isContainLeftIcon = true
        usernameTextField.setLeftView(#imageLiteral(resourceName: "icon_user"))

        remeberMeButton.setImage(#imageLiteral(resourceName: "unchecked-unfilled"), for: .selected)

        guard let loginData = loginDetails else {
            print("Empty loginDetails")
            return
        }

        usernameTextField.text = loginData["email"] as? String
        remeberMeButton.isSelected = true
        remeberMeButton.setImage(#imageLiteral(resourceName: "checkbox-filled"), for: .selected)
    }

    func setFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.remeberMeBtn.set(fontSize: 18)
            self.registerNewUser.set(fontSize: 18)
            self.sendOtpButton.set(fontSize: 18)
        }

    }

    func validate() -> Bool {
        var userName = ""
        /*
        let data = UserProfile.getUserProfile()
        if((data) != nil){
            userName = data!["EmployeeCode"]!
        print("userName=",userName)
        }
        */
        if usernameTextField.text == "" {
            usernameTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter username.")
            return true
        }
        /* 
        else if (userName != usernameTextField.text ){
            usernameTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Enter valid details.")
            return true
        }
        */
        return false
    }

    func setupLoginScreen(){
        /*
        let loginView = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        // UIApplication.shared. = NavigationBarUtils.setupNavigationController(viewController: loginView)
        //let loginView = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginView.isOTP = "1"
        self.present(loginView, animated: true, completion: nil) */
        //self.navigationController?.popToRootViewController(animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController.userName = self.usernameTextField.text
        appDelegate.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
        appDelegate.window?.makeKeyAndVisible()
    }

    //generateOTPapi call
    func generateOTPForMobileApiCall() {
        let registrationDetails = UserProfile.getUserProfile()
        let empCode = registrationDetails!["EmployeeCode"]!
        let userName = self.usernameTextField.text ?? ""
        let uName = userName.trimmingCharacters(in: .whitespaces)
        print("userName =\(uName)")
        let dataModel = DataModel(userName:uName, OTP: nil, deviceId: Const.uniqueDeviceUUID, employeeCode: empCode)
        let parameters = dataModel.toJSON()

        self.view.showLoading()
        APIManager.generateOTPForMobile(param: parameters) { status, response, error in

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
                    print("GenerateOTPForMobile responce = ",response!)
                  // let responceArray = response?.value(forKey: "data")as?[NSDictionary]

                      // handle responce here
                     self.setupLoginScreen()

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

    //MARK: IBActions
    @IBAction func sendOtpAction(_ sender: UIButton) {
        //self.setuploginScreen()
        ///*
        if !validate() {
            self.generateOTPForMobileApiCall()

            /*
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

            let defaults = UserDefaults.standard
            defaults.bool(forKey: "isRegistered")

            if (defaults.bool(forKey: "isRegistered")){
                self.loginApiCall()
            }else{
                self.view.showErrorMessage(message: "Please register first.")
            }
             */
        }
//*/

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
        self.setupLoginScreen()
    }

    @IBAction func showRegisterView(_ sender: UIButton) {
        let registrationView = UIStoryboard.Main().instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        self.present(registrationView, animated: true, completion: nil)
    }
}
