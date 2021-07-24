//
//  AppVersionChecker.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 01/05/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import Foundation
import Alamofire

class AppVersionChecker {
    
    public static let shared = AppVersionChecker()
    
    var newVersionAvailable: Bool?
    var appStoreVersion: String?
    
    func checkAppStore(callback: ((_ versionAvailable: Bool?, _ version: String?)->Void)? = nil) {
        let ourBundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        Alamofire.request("https://itunes.apple.com/lookup?bundleId=\(ourBundleId)").responseJSON { response in
            var isNew: Bool?
            var versionStr: String?
            
            if let json = response.result.value as? NSDictionary,
               let results = json["results"] as? NSArray,
               let entry = results.firstObject as? NSDictionary,
               let appVersion = entry["version"] as? String,
               let ourVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            {
                isNew = ourVersion != appVersion
                versionStr = appVersion
                print("ourVersion =\(ourVersion)")
                print("appVersion =\(appVersion)")
            }
            
            
            self.appStoreVersion = versionStr
            self.newVersionAvailable = isNew
            callback?(isNew, versionStr)
        }
    }
}
//

func showUpdateAlert(message : String, appStoreURL: String, isForceUpdate: Bool) {
    
    let controller = UIAlertController(title: "New Version", message: message, preferredStyle: .alert)
    
    //Optional Button
    if !isForceUpdate {
        controller.addAction(UIAlertAction(title: "Later", style: .cancel, handler: { (_) in }))
    }
    
    controller.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
        guard let url = URL(string: appStoreURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }))
    
    let applicationDelegate = UIApplication.shared.delegate as? AppDelegate
    applicationDelegate?.window?.rootViewController?.present(controller, animated: true)
    
}
//AppStoreUpdate.shared.showAppStoreVersionUpdateAlert(isForceUpdate: false/true)
/*
 VersionCheck.shared.checkAppStore() { isNew, version in
 print("IS NEW VERSION AVAILABLE: \(isNew), APP STORE VERSION: \(version)")
 }
 */

//https://stackoverflow.com/questions/6256748/check-if-my-app-has-a-new-version-on-appstore
