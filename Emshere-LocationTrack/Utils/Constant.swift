//
//  Const.swift
//  UniksApp
//
//  Created by Kalpesh Muthe on 23/12/2017.
//  Copyright © 2017 SampleCode. All rights reserved.
//

import Foundation
import UIKit

class Const {
    
    //So it can't be called by anyone else
    private init() { }
    
    /*
     1. All the constants goes here for debug/Live basis.
     */
    struct appUrl {
        // base url
        
        static let employeeApi = "EmployeeApi/"
        static let employeeApp = "EmployeeApp/"
        static let appStoreUrl = "https://apps.apple.com/in/app/emsphere-enterprise/id1425384564"
        static var mainUrl: String {
            
            #if DEVELOPMENT
            return "http://192.168.1.54/Empower_Mobile/app/Api/EmployeeApi"
            
            #else
            return "http://192.168.1.54/Empower_Mobile/app/Api/EmployeeApi"
            
            #endif
        }
        
        static var baseUrl: String {
            
            return "http://emcloud.emsphere.com/Sany_Mobile_Test/app"
            
            
        }
        
        static var licenseUrl: String {
            
            return "https://cloud.emsphere.com/Enterprise_MobileAppService/api/User/"
        }
        
        static var OTPUrl: String {
            
            return "http://125.99.69.58/ValueLab/app/api/EmployeeApi/"
            
        }
        
        static var locationUrl:String {
              return "http://emcloud.emsphere.com/Enterprise_LocationTracking_Mobileapp/app/api/EmployeeAPi/AddEmployeeMobileLocationTrackingdetails"
        }
    }
    
    
    
    static var  googleMapAPIKey: String {
        return "AIzaSyAGFc19Au7TQUwyHFsja-J6x5rAnSbJws8"
    }
    
    static let appName = "emSphere"
    
    static let arrowUnichar = "\u{2794}"
    // app short Url
    static let onelinkURL = "http://"
    static var isManager = ""
    
    //network call time out
    static let timeOutInterval = 60
    
    static let maxDigitOfMobileNo = 9 //  
    
    static let minPasswordSize = 10
    
    static let minGraphPoint = 20
    
    static var deviceOS: String {
        return UIDevice.current.systemVersion
    }
    
    static var deviceName: String {
        return UIDevice.current.model
    }
    
    static var deviceType: String {
        return "1"
    }
    
    static var releaseVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var buildVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
    static var deviceLanguage: String? {
        if NSLocale.current.languageCode == "en" || NSLocale.current.languageCode == "en" {
            return NSLocale.current.languageCode
        } else {
            return "en"
        }
    }
    // "IS_UDID"
    
    static var deviceToken: String {
        if UserDefaults.standard.value(forKey: "DEVICE_TOKEN") != nil {
            return UserDefaults.standard.value(forKey: "DEVICE_TOKEN") as! String
        }
        return"1234567890dummyToken"
    }
    
    static var uniqueDeviceUUID: String {
        if UserDefaults.standard.value(forKey: "IS_UDID") != nil {
            return UserDefaults.standard.value(forKey: "IS_UDID") as! String
        }
        return ""
    }
    
    static var notificationBadgeCount: String? {
        if UserDefaults.standard.value(forKey: "NOTIFICATION_COUNT") != nil {
            return UserDefaults.standard.value(forKey: "NOTIFICATION_COUNT") as? String
        }
        return nil
    }
    
    static var deviceUUID: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}

