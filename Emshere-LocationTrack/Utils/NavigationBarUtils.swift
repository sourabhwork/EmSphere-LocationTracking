//
//  NavigationBarUtils.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 20/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class NavigationBarUtils {
    
    // setup navigationController with app custom setting
    public static func setupNavigationController (viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1405271888, green: 0.1678775847, blue: 0.292804271, alpha: 1)
        navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isOpaque = true
        navigationController.navigationBar.layer.masksToBounds = false
        //navigationController.navigationBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       // navigationController.navigationBar.layer.shadowOpacity = 0.8
        //navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        //navigationController.navigationBar.layer.shadowRadius = 2
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navigationController
    }

    public static func setupNavigationBar(navigationController:UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1405271888, green: 0.1678775847, blue: 0.292804271, alpha: 1)
        navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isOpaque = true
        navigationController.navigationBar.layer.masksToBounds = false
//        navigationController.navigationBar.layer.shadowColor = UIColor.white.cgColor
//        navigationController.navigationBar.layer.shadowOpacity = 0.8
//        navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
//        navigationController.navigationBar.layer.shadowRadius = 2
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.orange
    }
    
    // setup transperant navigation bar
    public static func setTransperentNavigationBar(navigationController:UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
    }
    

    
    
    //Get previous view controller of the navigation stack
    public static func previousViewController(navigationController:UINavigationController) -> UIViewController?{
        let lenght = navigationController.viewControllers.count
        let previousViewController: UIViewController? = lenght >= 2 ? navigationController.viewControllers[lenght-2] : nil
        return previousViewController
    }
}
