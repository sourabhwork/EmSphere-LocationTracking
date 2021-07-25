//
//  ChangePasswordViewController.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 14/03/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet var oldPasswodTF: ACFloatingTextfield!
    @IBOutlet var newPasswodTF: ACFloatingTextfield!
    @IBOutlet var confirmPasswodTF: ACFloatingTextfield!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var closeButton: UIButton!
    
    //MARK:Properies
    var isExecuted = false
    
    //MARK:- viewController Delegate methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        if isExecuted == false{
            isExecuted = true
            submitBtn.makeCornerEdge(cornerRadius: closeButton.frame.size.height/2)
            
            closeButton.makeCornerEdge(cornerRadius: submitBtn.frame.size.height/2)
            //.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (submitBtn.frame.size.height/2), height: (submitBtn.frame.size.height/2)))
            // closeButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (closeButton.frame.size.height/2), height: (closeButton.frame.size.height/2)))
        }
    }
    
    private func setupView(){
        oldPasswodTF.setLeftView(#imageLiteral(resourceName: "icon_password"))
        oldPasswodTF.setupTheme("Enter Old Password")
        oldPasswodTF.isSecureTextEntry = true
        newPasswodTF.setupTheme("Enter New Password")
        newPasswodTF.setLeftView(#imageLiteral(resourceName: "icon_password"))
        newPasswodTF.isSecureTextEntry = true
        confirmPasswodTF.setupTheme("Confirm New Password")
        confirmPasswodTF.setLeftView(#imageLiteral(resourceName: "icon_password"))
        confirmPasswodTF.isSecureTextEntry = true
        self.setNavigationBar()
    }
    
    func setNavigationBar() {
        
        self.setSideMenuBarItem()
        self.title = "Change Password"
        //       self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "ic_action_toolbarleft_arrow"))
        //        let bellButton = UIButton(type: .custom)
        //        bellButton.setBackgroundImage(#imageLiteral(resourceName: "icon_notification"), for: .normal)
        //        bellButton.addTarget(self, action: #selector(showNotifications), for: .touchUpInside)
        //        let notificationBarButton = UIBarButtonItem(customView: bellButton)
        //        notificationBarButton.setBadge(text: Const.notificationBadgeCount)//logo
        // self.navigationController?.navigationBar.barTintColor = .clear
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        let backImageButton = UIButton(type: .custom)
        backImageButton.frame = CGRect(x: 0, y: 9, width: 25, height: 25)
        backImageButton.setBackgroundImage(#imageLiteral(resourceName: "ic_action_toolbarleft_arrow"), for: .normal)
        backImageButton.addTarget(self, action: #selector(didTappedCloseButn), for: .touchUpInside)
        view.addSubview(backImageButton)
        
        let logoImage = UIImageView(frame: CGRect(x: 33, y: 9, width: 25, height: 25))
        logoImage.image = UIImage(named: "em_logo_small.png")
        logoImage.contentMode = .scaleAspectFit
        view.addSubview(logoImage)        
        let leftButton = UIBarButtonItem(customView: view)        
        
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func setLoginView(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        appDelegate.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
        appDelegate.window?.makeKeyAndVisible()
    }
    //MARK:no nedd of this func
    @objc func showNotifications() {
        /*
        let applicationApproval = UIStoryboard.ApplicationApprovals().instantiateViewController(withIdentifier: "ApplicationApprovalPager")as!ApplicationApprovalPager
        self.navigationController?.pushViewController(applicationApproval, animated: true)
        */
    }
    
    
    func didValidate() -> Bool {
        if oldPasswodTF.text == "" {
            oldPasswodTF.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter old password.")
            return true
        }else if newPasswodTF.text == ""{
            newPasswodTF.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter new password.")
            return true
        }else if confirmPasswodTF.text == ""{
            newPasswodTF.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter confirm new password.")
            return true
        }
        
        return false
    }
    //MARK:IBActions
    @IBAction func didTappedSubmitButn(_ sender: Any) {
        if self.didValidate() == false{
            self.didMakeChangedPasswordApiCall()
        }
    }
    
    @IBAction func didTappedCloseButn(_ sender: Any) {
       // self.setupHomeScreen()
        self.didSetupHomeScreen()
    }
    
    func didSetupHomeScreen(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupHomeScreen() {

           let appDelegate = UIApplication.shared.delegate as! AppDelegate

           
       }
    
}//end of vc

//MARK:Api call
extension ChangePasswordViewController{
    //login api call
    func didMakeChangedPasswordApiCall() {
        //  UserProfile.clearIsloginByOTP()
        let registrationDetails = UserProfile.getUserProfile()
        let empCode = registrationDetails!["EmployeeCode"]!
        let userName = UserProfile.getUserName() ?? ""//registrationDetails!["OfficalEmailID"] ?? "" // UserProfile.getUserName() ?? ""//
        let token = UserProfile.getLoginToken()
        let oldPass = self.oldPasswodTF.text
        let newPass = self.newPasswodTF.text
        let confirmPass = self.confirmPasswodTF.text
        let deviceId = Const.uniqueDeviceUUID
        
        //  let dataModel = DataModel(userName: empCode, employeeCode:empCode ,deviceId: Const.uniqueDeviceUUID)
       
        let dataModel = DataModel(userName: userName, employeeCode: empCode, deviceId: deviceId, token: token, oldPass: oldPass, newPass: newPass, confirmPass: confirmPass)
        
        let parameters = dataModel.toJSON()
        
        self.view.showLoading()
        APIManager.didChangePasswordApi(param: parameters) { status, response, error in
            if status == true {
                self.view.dissmissLoading()
                //api success // status code = 200
                
                if (response!.value(forKey: "status") == nil){
                    self.view.showErrorMessage(message: response?.value(forKey:"message") as? String ?? "")
                    return
                }else{
                    //Below get suuccess data
                    let statusValue = response!.value(forKey: "status") as? String ?? "0"
                    if statusValue == "1"{
                        let successMeg = response?.value(forKey:"message") as? String ??
                            ConstantMesssages.Success.passowordChanged
                        DispatchQueue.main.async {
                            self.view.endEditing(true)
                            self.view.showSuccessMessage(message:successMeg)
                            self.setLoginView()
                        }
                    }else{
                         let errMeg = response?.value(forKey:"message") as? String ?? ""
                         DispatchQueue.main.async {
                         self.view.showErrorMessage(message: errMeg)
                        }
                    }
                }
                    
                }else if error != nil {
                    //api failure
                    self.view.dissmissLoading()
                    print(error! as APIError)
                    DispatchQueue.main.async {
                        self.view.showErrorMessage(message: error!.errorDescription)
                    }
                }
            }
        }
        
        
}//end Api manager
