//
//  UIViewControllerExtensions.swift
//  EmsphereLocationTracking
//
//  Created by Dhiraj Chaudhari on 18/07/21.
//  Copyright © 2021 Dhiraj Chaudhari. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setSideMenuBarItem() {
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "ic_hambur"))
       // self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
       
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil

    }
    public func addLeftBarButtonWithImage(_ buttonImage: UIImage) {
        /*  let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleLeft))
         navigationItem.leftBarButtonItem = leftButton */

         let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
         let backImageButton = UIButton(type: .custom)
         backImageButton.frame = CGRect(x: 0, y: 9, width: 25, height: 25)
         backImageButton.setBackgroundImage(buttonImage, for: .normal)
     //    backImageButton.addTarget(self, action: #selector(self.toggleLeft), for: .touchUpInside)
//
         let logoImage = UIImageView(frame: CGRect(x: 33, y: 9, width: 25, height: 25))
         logoImage.image = UIImage(named: "em_logo_small.png")
         logoImage.contentMode = .scaleAspectFit
         view.addSubview(backImageButton)
         view.addSubview(logoImage)
         let leftButton = UIBarButtonItem(customView: view)
      //   leftButton.action = #selector(self.toggleLeft)
         navigationItem.leftBarButtonItem = leftButton
     }
     
     public func addRightBarButtonWithImage(_ buttonImage: UIImage) {
        // let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleRight))
       //  navigationItem.rightBarButtonItem = rightButton
     }
}
