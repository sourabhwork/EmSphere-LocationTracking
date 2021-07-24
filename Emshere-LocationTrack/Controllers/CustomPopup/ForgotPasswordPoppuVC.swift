//
//  ForgotPasswordPoppuVC.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 05/04/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class ForgotPasswordPoppuVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var headerLable: UILabel!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var containerViewWidthConstaint: NSLayoutConstraint!
    @IBOutlet weak var closeButnWitdthConstarint: NSLayoutConstraint!
    @IBOutlet weak var sendButnWitdthConstarint: NSLayoutConstraint!
    @IBOutlet weak var usernameTF: BCFloatingTextfield!
    
    //MARK:Propeties
    var alertDelegate: ForgotPasswordAlertDelegate?
    
    //MARK:View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAllTextField()
        self.setupFontForIpad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submitButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (submitButton.frame.size.height/2), height: (submitButton.frame.size.height/2)))
        cancelButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (cancelButton.frame.size.height/2), height: (cancelButton.frame.size.height/2)))
       
        let viewWidth = self.view.frame.size.width
        print("View Width =",viewWidth)
        if (UIDevice.current.userInterfaceIdiom == .pad){
            self.closeButnWitdthConstarint.constant = 85
            self.sendButnWitdthConstarint.constant = 270
            self.containerViewWidthConstaint.constant = viewWidth * 0.55
            self.cancelButton.layoutIfNeeded()
            self.submitButton.layoutIfNeeded()
            self.cancelButton.set(fontSize: 16)
            self.submitButton.set(fontSize: 16)
           
            self.view.layoutIfNeeded()
        } else {
            
            let screenSize: CGRect = UIScreen.main.bounds
            let screenWidth = screenSize.width
            switch screenWidth {
            case 0...320:
                print("iPhone 5 portrait")
                self.containerViewWidthConstaint.constant = viewWidth * 0.94
                break
           
            default:
                // iPhone 6 Plus portrait
                /*
                if screenWidth > 400{
                    self.closeButnWitdthConstarint.constant = 70
                    self.sendButnWitdthConstarint.constant = 230
                    self.cancelButton.layoutIfNeeded()
                    self.submitButton.layoutIfNeeded()
                    self.cancelButton.set(fontSize: 14)
                    self.submitButton.set(fontSize: 14)
                    self.view.layoutIfNeeded()
                }
                */
                print("iPhone6 Plus portrait")
                self.containerViewWidthConstaint.constant = viewWidth * 0.9
                break
            }
        }
    }
    
    func setupAllTextField() {
        self.usernameTF.setupThemeInForm("Enter username")
        
    }
    
    func setupFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.headerLable.font = self.headerLable.font.withSize(18)
            self.usernameTF.font = self.usernameTF.font?.withSize(18)
            self.submitButton.set(fontSize: 18)
            self.cancelButton.set(fontSize: 18)
        }
    }
    
    func didValidate()->Bool{
        if (self.usernameTF.text ?? "" == ""){
            self.view.showErrorMessage(message: "Please enter Username.")
            return false
        } else {
            return true
        }
    }
    
    //MARK: IBActions
    @IBAction func submit(_ sender: UIButton) {
        //MARK:do here api call
        if self.didValidate(){
            self.didMakeForgrtPasswordApiCall()
        }
       
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

//MARK:api call

extension ForgotPasswordPoppuVC{
    
    func didMakeForgrtPasswordApiCall(){
        if let serviceUrl = UserProfile.getServiceURL(){
            
            let url = serviceUrl + Const.appUrl.employeeApi + "ForgotPassword"
            let registrationDetails = UserProfile.getUserProfile()
            let empCode = registrationDetails!["EmployeeCode"] ?? ""
            let deviceId = Const.uniqueDeviceUUID
            let userName = self.usernameTF.text ?? ""
            
             let dataModel = DataModel(userName: userName, employeeCode: empCode, deviceId: deviceId)
             
             let parameters = dataModel.toJSON()
             
             self.view.showLoading()
            APIManager.didCallForgotpassowrdApi(param:parameters, servicrUrl: url) { (status, response, error) in
                if status == true {
                    self.view.dissmissLoading()
                    //api success // status code = 200
                    if let responseResult = response{
                        if (responseResult.value(forKey: "status") == nil){
                         //   self.view.showErrorMessage(message: )
                            
                           let errMeg = responseResult.value(forKey:"message") as? String ?? ""
                            
                            self.presentAlert(withTitle: "Error", message: errMeg)
                        return
                    }else{
                        //Below get suuccess data
                        let statusValue = responseResult.value(forKey: "status") as? String ?? "0"
                        if statusValue == "1"{
                            let successMeg = responseResult.value(forKey:"message") as? String ??
                                ConstantMesssages.Success.forgotPassword
                            DispatchQueue.main.async {
                                self.view.endEditing(true)
                               // self.view.showSuccessMessage(message:successMeg)
                               
                               // self.dismiss(animated: true, completion: nil)
                                self.dismiss(animated: true) {
                                    self.alertDelegate?.didShowMessgae(msg: successMeg)
                                }
                                //self.presentAlert(withTitle: "", message: successMeg)
                            }
                        }else{
                            let errMeg = responseResult.value(forKey:"message") as? String ?? ""
                             DispatchQueue.main.async {
                                self.presentAlert(withTitle: "Error", message: errMeg)
                            // self.view.showErrorMessage(message: errMeg)
                            }
                        }
                    }
                        
                    }
                    }else if error != nil {
                        //api failure
                        self.view.dissmissLoading()
                        print(error! as APIError)
                        DispatchQueue.main.async {
                            self.presentAlert(withTitle: "Error", message: error!.errorDescription)
                           // self.view.showErrorMessage(message: error!.errorDescription)
                        }
                    }
                }
            
        }else{
            self.presentAlert(withTitle: "", message: "Please register yourself.")
            return
        }
         
    }
    
}
