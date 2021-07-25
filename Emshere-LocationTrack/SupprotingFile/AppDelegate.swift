//
//  AppDelegate.swift
//  Emshere-LocationTrack
//
//  Created by Dhiraj Chaudhari on 18/07/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import UIKit
import Firebase
import DropDown
import GoogleMaps
import SwiftyJSON
import Crashlytics
import Fabric
import SwiftMessages
import UserNotifications
import IQKeyboardManagerSwift
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    
    var createTable:String="CREATE TABLE IF NOT EXISTS OfflineAttendanceMark(id INTEGER PRIMARY KEY AUTOINCREMENT,swipeTime TEXT,latitude TEXT,longitude TEXT,door TEXT,locationAddress TEXT,swipeImageFileName TEXT,isOnlineSwipe TEXT,remark TEXT,LocationProvider TEXT)"
    
    var MarkAttendanceHistoryTable = "CREATE TABLE IF NOT EXISTS MarkAttendanceHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,markAttendanceEmpId TEXT,markDate TEXT,markTime TEXT,markStatus TEXT,attendanceId TEXT,serverSyncStatus TEXT)"
    
    // var createTableQueryArray = ["CREATE TABLE IF NOT EXISTS OfflineAttendanceMark(id INTEGER PRIMARY KEY AUTOINCREMENT,swipeTime TEXT,latitude TEXT,longitude TEXT,door TEXT,locationAddress TEXT,swipeImageFileName TEXT,isOnlineSwipe TEXT,remark TEXT,LocationProvider TEXT)","CREATE TABLE IF NOT EXISTS MarkAttendanceHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,markAttendanceEmpId TEXT,markDate TEXT,markTime TEXT,markStatus TEXT)"]
    
    var createTableQueryArray = ["CREATE TABLE IF NOT EXISTS OfflineAttendanceMark(id INTEGER PRIMARY KEY AUTOINCREMENT,swipeTime TEXT,latitude TEXT,longitude TEXT,door TEXT,locationAddress TEXT,swipeImageFileName TEXT,isOnlineSwipe TEXT,remark TEXT,LocationProvider TEXT)","CREATE TABLE IF NOT EXISTS MarkAttendanceHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,markAttendanceEmpId TEXT,markDate TEXT,markTime TEXT,markStatus TEXT,attendanceId TEXT,serverSyncStatus TEXT)"]
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print("App delegate launch")
        //MARK:code for vaoiding balck theme
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        self.setUDID_ByKeychain()
        
        GMSServices.provideAPIKey("AIzaSyAGFc19Au7TQUwyHFsja-J6x5rAnSbJws8")
        
        //Firebase configuration
        self.setupFirebase(application: application)
        
        // Use Firebase library to configure APIs
        //FirebaseApp.configure()
        //  Messaging.messaging().delegate = self
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Fabric.with([Crashlytics.self])
        //Fabric.sharedSDK().debug = true
        //Crashlytics.sharedInstance().crash()
        
        //Enable Keyboard manager
        IQKeyboardManager.shared.enable = true
        
        //custom DropDwon
        DropDown.startListeningToKeyboard()
        
        for query in self.createTableQueryArray{
            let result = DataBaseHandler.shared.createTable(query:query)
            print("create Table result=",result)
        }
        
        /*
         NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "IncreaseBadgeCount"), object: nil)
         NotificationCenter.default.addObserver(self,selector: #selector(self.showCurrentLocationOnMapview),name: Notification.Name(rawValue: "IncreaseBadgeCount"),object: nil) */
        
        if (UserProfile.getIsLogin() ?? "" != "1" && UserProfile.getIsAllowLoginUsingOTP() == "1"){
            print("Enter in OTP Login")
            let otpView = UIStoryboard.Main().instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            //self.present(otpView, animated: true, completion: nil)
            self.window?.rootViewController = otpView//NavigationBarUtils.setupNavigationController(viewController: loginViewController)
            self.window?.makeKeyAndVisible()
        }else if(UserProfile.getIsLogin() == "1" && UserProfile.getIsAllowLoginUsingOTP() == "1"){
            if(UserProfile.getIsLogoutByOTP() == "1"){
                print("Enter in OTP Login")
                let otpView = UIStoryboard.Main().instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                //self.present(otpView, animated: true, completion: nil)
                self.window?.rootViewController = otpView//NavigationBarUtils.setupNavigationController(viewController: loginViewController)
                self.window?.makeKeyAndVisible()
                
            } else{
                print("Enter in setupHome()")
                self.setupHome()
            }
        } else {
            print("Enter in setupLogin")
            self.setupLogin()
        }
        
        
        return true
    }
    
    
    func setupHome(){
        
        //MARK:use Camera view
        let markAttandance = UIStoryboard.Main().instantiateViewController(withIdentifier: "MarkAttandanceViewController") as! MarkAttandanceViewController
        self.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: markAttandance)
               self.window?.makeKeyAndVisible()
        
        //MARK:use map view
        /*
         let markAttandance1 = UIStoryboard.Main().instantiateViewController(withIdentifier: "MarkAttedanceMapViewController") as! MarkAttedanceMapViewController
        self.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: markAttandance)
        self.window?.makeKeyAndVisible()
 */
        /*
       if(UserProfile.getIsHideCameraForMarkAttendance() == "0") {
                  print("Enter in if condn")
                  let markAttandance = UIStoryboard.Home().instantiateViewController(withIdentifier: "MarkAttandanceViewController") as! MarkAttandanceViewController
                  self.navigationController?.pushViewController(markAttandance, animated: true)
                  
              } else {
                  print("Enter in else condn")
                  let markAttandance1 = UIStoryboard.Home().instantiateViewController(withIdentifier: "MarkAttedanceMapViewController") as! MarkAttedanceMapViewController
                  self.navigationController?.pushViewController(markAttandance1, animated: true)
              } */
    }
    
    func setUDID_ByKeychain() {
        let udid: String? = KeychainWrapper.standard.string(forKey: "Device_ID")
        if ((udid) != nil){
            //print("my constant udid = ",udid)
            UserProfile.saveUDID(status: udid)
            //print("unique udid from user default = ",UserProfile.getUDID())
            //print("unique udid from from Constant Claas = ",Const.uniqueDeviceUUID)
            
        } else {
            let _: Bool = KeychainWrapper.standard.set(Const.deviceUUID ?? "", forKey: "Device_ID")
            //print("not seted before, now set here")
            let udid: String? = KeychainWrapper.standard.string(forKey: "Device_ID")
            UserProfile.saveUDID(status: udid)
            //print("my constant udid after set = ",udid)
        }
        
    }
    
    //jump to home
    func setupLogin() {
        let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //let loginViewController = UIStoryboard.Home().instantiateViewController(withIdentifier: "MarkAttandanceViewController") as! MarkAttandanceViewController
        self.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
        self.window?.makeKeyAndVisible()
    }
    
    //MARK: Setup Firebase configuration
    func setupFirebase (application: UIApplication) {
        
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber =  0
        
    }
    
    //MARK:code on 25-07-2021 for backgrounf location update need to do some code
    func didMakeLocationUpdateApiCall() {
        //  UserProfile.clearIsloginByOTP()
        let registrationDetails = UserProfile.getUserProfile()
        
        let employeeId = registrationDetails!["EmployeeID"] ?? ""
        
        
        let deviceId = Const.uniqueDeviceUUID
        
        //MARK:take lat and long and get adress from it from reversimg geoaging by lat and long and set to data model
        
        let dataModel = DataModel(employeeId: employeeId, deviceid: deviceId, latitude: nil, longitude: nil, locationAddress: nil, locationProvider: "GPS")
        
        let parameters = dataModel.toJSON()
        
        APIManager.didCallLocationUpdateApi(param: parameters, servicrUrl: Const.appUrl.locationUrl) { (status, response, error) in
            if status == true {
                
                if (response!.value(forKey: "status") == nil){
                    return
                }else{
                    //Below get suuccess data
                    let statusValue = response!.value(forKey: "status") as? String ?? "0"
                    if statusValue == "1"{
                        //MARK:Success
                        
                        
                    }else{
                        //MARK:Error
                    }
                }
                
            }else if error != nil {
                //api failure
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

