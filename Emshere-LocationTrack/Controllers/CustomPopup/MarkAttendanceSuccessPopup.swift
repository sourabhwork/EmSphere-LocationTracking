//
//  MarkAttendanceSuccessPopup.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 02/06/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class MarkAttendanceSuccessPopup: UIViewController {
    // Properties
    var date = ""
    var inOutStatus = ""
    var source = ""
    var rootSource = ""

    @IBOutlet var inOutLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet var submittedSuccessfullyLabel: UILabel!
    
    @IBOutlet var containerViewWidthConstaint: NSLayoutConstraint!
    @IBOutlet var punchSuccessWidthConstaint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setPopView()
        self.setupFontForIpad()
        
    }

    func setPopView() {
        self.dateLabel.text = self.date
        self.inOutLabel.text = self.inOutStatus
        if(self.inOutStatus == "OUT"){
            self.inOutLabel.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }

    func setupFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.inOutLabel.font = self.inOutLabel.font.withSize(18)
            self.inOutLabel.font = self.inOutLabel.font.withSize(18)
            self.okButton.set(fontSize: 18)
            self.submittedSuccessfullyLabel.font = self.submittedSuccessfullyLabel.font.withSize(18)

    }
  }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        okButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (okButton.frame.size.height/2), height: (okButton.frame.size.height/2)))

        inOutLabel.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (inOutLabel.frame.size.height/2), height: (inOutLabel.frame.size.height/2)))

        let viewWidth = self.view.frame.size.width
        print("View Width =",viewWidth)
        if (UIDevice.current.userInterfaceIdiom == .pad){
            self.containerViewWidthConstaint.constant = viewWidth * 0.55
            self.punchSuccessWidthConstaint.constant = 180
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
                print("iPhone6 Plus portrait")
                self.containerViewWidthConstaint.constant = viewWidth * 0.9
                break
            }
        }


        
    }

// Mark IBOutltes

    @IBAction func okButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
