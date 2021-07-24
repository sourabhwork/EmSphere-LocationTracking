//
//  RemarkPopup.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 18/05/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit
// Protocol
protocol remarkDelegate: class {
    func getRemark(remark : String)
}
class RemarkPopup: UIViewController {

    // Delegate
    var delegate : remarkDelegate! = nil

    //MARK: - IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var remarkLable: UILabel!
    @IBOutlet var remarkTextView: UITextView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var containerViewWidthConstaint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFontForIpad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        submitButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (submitButton.frame.size.height/2), height: (submitButton.frame.size.height/2)))
        cancelButton.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: (cancelButton.frame.size.height/2), height: (cancelButton.frame.size.height/2)))
        let viewWidth = self.view.frame.size.width
        print("View Width =",viewWidth)
        if (UIDevice.current.userInterfaceIdiom == .pad){
            self.containerViewWidthConstaint.constant = viewWidth * 0.55
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

    func setupFontForIpad(){
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.remarkLable.font = self.remarkLable.font.withSize(18)
            self.remarkTextView.font = self.remarkTextView.font?.withSize(18)
            self.submitButton.set(fontSize: 18)
            self.cancelButton.set(fontSize: 18)
        }
    }

  //MARK: IBActions
    @IBAction func submit(_ sender: UIButton) {

        if (self.remarkTextView.text != ""){

            self.dismiss(animated: true, completion: {
                self.delegate.getRemark(remark: self.remarkTextView.text)
            })
        } else {
            self.view.showErrorMessage(message: "Please enter remark.")
        }
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

   
}
