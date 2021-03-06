//
//  SceneDelegate.swift
//  Emshere-LocationTrack
//
//  Created by Dhiraj Chaudhari on 18/07/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        print("🙏🙏  connectionOptions connectionOptions 🙏 🙏")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("🙏🙏  sceneDidBecomeActive sceneDidBecomeActive 🙏 🙏")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("🙏🙏  sceneWillResignActive sceneWillResignActive 🙏 🙏")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
       print("🙏🙏  sceneWillEnterForeground  sceneWillEnterForeground 🙏🙏")
//        var employeeId = ""
//        if let registrationDetails = UserProfile.getUserProfile() {
//            employeeId = registrationDetails["EmployeeID"] ?? ""
//        }
//        BackgroundManager.sharedInstance.stopTimer()
//        if SwiftLocationManager.getIsAuthorization() && !employeeId.isEmpty {
//            print("Enter inside getIsAuthorization and ")
//            BackgroundManager.sharedInstance.startTimer()
//        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("sceneDidEnterBackground  sceneDidEnterBackground")
        
        var employeeId = ""
        if let registrationDetails = UserProfile.getUserProfile() {
            employeeId = registrationDetails["EmployeeID"] ?? ""
        }
        //UserProfile.getUserIsLogin()
        // !employeeId.isEmpty
        if SwiftLocationManager.getIsAuthorization() && UserProfile.getUserIsLogin() {
            print("Enter inside getIsAuthorization and ")
            //BackgroundManager.sharedInstance.startTimer()
            DispatchQueue.global(qos: .background).async {
                BackgroundManager.sharedInstance.startTimer()
            }
            //RunLoop.main.add(BackgroundManager.bgTimer, forMode: .tracking)
            //RunLoop.current.run()
        }
    }

    

}

