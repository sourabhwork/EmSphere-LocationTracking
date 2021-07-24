//
//  ViewUtils.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 20/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import UIKit
import SwiftMessages
import PKHUD

/*
 1. All the UIView related common custom function goes here.
 */

extension ACFloatingTextfield {
    func setupTheme(_ placeholder: String) {
        self.placeholder = placeholder
        self.placeHolderColor = UIColor.white
        self.textColor = UIColor.white
        self.selectedPlaceHolderColor = UIColor.floatLoginLabel()
        self.lineColor = UIColor.black
        self.selectedLineColor = UIColor.colorAccent()
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.font = UIFont(name: "Roboto-Regular", size: 15.0)
            // Menlo-BoldItalic
        }else {
            self.font = UIFont(name: "Roboto-Regular", size: 18.0)
        }
    }
    

}

extension BCFloatingTextfield {
    func setupTheme(_ placeholder: String) {
        self.placeholder = placeholder
        self.placeHolderColor = UIColor.white
        self.textColor = UIColor.white
        self.selectedPlaceHolderColor = UIColor.floatLoginLabel()
        self.lineColor = UIColor.black
        self.selectedLineColor = UIColor.colorAccent()
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.font = UIFont(name: "Roboto-Regular", size: 15.0)
        }else {
            self.font = UIFont(name: "Roboto-Regular", size: 18.0)
        }
    }

    
    func setupThemeInForm(_ placeholder: String) {
        self.placeholder = placeholder
        self.placeHolderColor = UIColor.textBackclr()
        self.textColor = UIColor.colorAccent()
        self.selectedPlaceHolderColor = UIColor.floatLoginLabel()
        self.lineColor = UIColor.darkGray
        self.selectedLineColor = UIColor.colorAccent()
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.font = UIFont(name: "Roboto-Regular", size: 13.0)
        }else {
            self.font = UIFont(name: "Roboto-Regular", size: 18.0)
        }
    }

    func setupThemeforPopupDropDown(_ placeholder: String) {
        self.placeholder = placeholder
        self.placeHolderColor = UIColor.textBackclr()
        self.textColor = UIColor.black
        self.selectedPlaceHolderColor = UIColor.floatLoginLabel()
        self.lineColor = UIColor.darkGray
        self.selectedLineColor = UIColor.colorAccent()
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.font = UIFont(name: "Roboto-Regular", size: 13.0)
        }else {
            self.font = UIFont(name: "Roboto-Regular", size: 18.0)
        }

    }
}//


extension UIImageView {
    // load image from URL
    func setImageFromURl(stringImageUrl url: String){
        if let url = NSURL(string: url) {
            DispatchQueue.global(qos: .default).async{
                if let data = NSData(contentsOf: url as URL) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data as Data)
                    }
                }
            }
        }
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize)-> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat.pi)
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat.pi
        }

        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size

        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()

        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)

        //   // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees))

        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat

        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }

        bitmap?.scaleBy(x: yFlip, y: -1.0)
        let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)

        bitmap?.draw(cgImage!, in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    func setTintColor(_ color: UIColor){

    }
}

extension UITableView {
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}

extension UIAlertController{
    class func customAlertController(title : String, message : String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        return alertController
    }
}

extension UILabel {
    func customisedAttributedString(_ text: String, range1: Int, color1: UIColor, font1: UIFont, range2: Int, color2: UIColor, font2: UIFont  ) {
        let customisedString = NSMutableAttributedString(string: text)
        customisedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color1, range:NSRange(location: 0, length: range1))
        customisedString.addAttribute(NSAttributedString.Key.font, value:font1 , range: NSRange(location: range1, length: range1))
        customisedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color2, range:NSRange(location: range1, length: range2))
        customisedString.addAttribute(NSAttributedString.Key.font, value:font2 , range: NSRange(location: range1, length: range2))
        self.attributedText = customisedString
    }
}

extension UISearchBar {
    func setCustomizedSearchBar(_ withPlaceholder: String) {
        self.tintColor = UIColor.white
        self.searchBarStyle = .minimal
        self.returnKeyType = .done
        self.isTranslucent = false
        let searchBarTextField = self.value(forKey: "searchField") as! UITextField
        searchBarTextField.textColor = UIColor.white
        searchBarTextField.tintColor = UIColor.white
        if #available(iOS 11.0, *) {
            searchBarTextField.textColor = UIColor.black
            searchBarTextField.tintColor = UIColor.black
            if let backgroundview = searchBarTextField.subviews.first {
                // Background color
                backgroundview.backgroundColor = UIColor.white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
}

extension UITextField {
    
    func customisedPlaceholder(_ placeholder: String) {
        let customisedPlaceholder = NSMutableAttributedString(string: placeholder)
        customisedPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range:NSRange(location: 0, length: placeholder.count))
        customisedPlaceholder.addAttribute(NSAttributedString.Key.font, value:UIFont.init(name: Font.appRegularFont, size: 16)! , range: NSRange(location: 0, length: placeholder.count))
        // Add attribute//UIFont.systemFont(ofSize: 14)
        self.attributedPlaceholder = customisedPlaceholder
    }
    
    func customisedPlaceholder(_ placeholder: String, placholderColor: UIColor) {
        let customisedPlaceholder = NSMutableAttributedString(string: placeholder)
        customisedPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: placholderColor, range:NSRange(location: 0, length: placeholder.count))
        customisedPlaceholder.addAttribute(NSAttributedString.Key.font, value:UIFont.init(name: Font.appRegularFont, size: 16)! , range: NSRange(location: 0, length: placeholder.count))
        // Add attribute//UIFont.systemFont(ofSize: 14)
        self.attributedPlaceholder = customisedPlaceholder
    }
    
    func customisedPlaceholder(_ placeholder: String, primaryColor: UIColor, secondaryColor: UIColor) {
        let customisedPlaceholder = NSMutableAttributedString(string: placeholder)
        customisedPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: primaryColor, range:NSRange(location: 0, length: placeholder.count - 1))
        customisedPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: secondaryColor, range:NSRange(location: placeholder.count - 1, length: 1))
        customisedPlaceholder.addAttribute(NSAttributedString.Key.font, value:UIFont.init(name: Font.appRegularFont, size: 16)! , range: NSRange(location: 0, length: placeholder.count))
        self.attributedPlaceholder = customisedPlaceholder
    }
    
    func setRightView(_ icon: UIImage){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        var imageView = UIImageView()
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.center = CGPoint(x: (view.frame.size.width - 10)/2, y: view.frame.size.height/2)
        imageView.image = icon
        imageView.contentMode = .center
        view.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = view
    }
    
    //set right view
    func setLeftView(_ icon: UIImage) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 35))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.center = CGPoint(x: (view.frame.size.width)/2, y: view.frame.size.height/2)
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        self.leftViewMode = .always
        self.leftView = view
    }
}

public extension UIDevice {

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }

}
extension UIView {
    
    //apply border to view
    func applyBorder(radius:CGFloat, color: UIColor = UIColor.clear, width:CGFloat = 0) {
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    // set color to status bar
    func setStatusBarBackgroundColor(color: UIColor) {
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView
            else {
                return
        }
        statusBar.backgroundColor = color
    }
    
    //make card view
    func cardView() {
        self.layer.shadowOffset =  CGSize(width: 0, height: 1)   // CGSizeMake(0, 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 0.65
        self.layer.cornerRadius = 1
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    }
    
    // Make circular View
    func makeCircular(width:CGFloat = 0, color: UIColor = UIColor.clear) {
        self.layer.cornerRadius = 0.5*self.bounds.size.width
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    // make filled circular view
    func addFilledCircle(fillColor: UIColor, outlineColor:UIColor) {
        let circleLayer = CAShapeLayer()
        let width = Double(self.bounds.size.width);
        let height = Double(self.bounds.size.height);
        circleLayer.bounds = CGRect(x: 2.0, y: 2.0, width: width-2.0, height: height-2.0)
        circleLayer.position = CGPoint(x: width/2 - 2, y: height/2 - 2);
        
        let rect = CGRect(x: 4.0, y: 4.0, width: width-4.0, height: height-4.0)
        let path = UIBezierPath.init(ovalIn: rect)
        circleLayer.path = path.cgPath
        circleLayer.fillColor = fillColor.cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = outlineColor.cgColor
        self.layer.addSublayer(circleLayer)
    }
    
    // make round corner
    func roundCorners(corners:UIRectCorner,cornerRadii: CGSize) {
        let rectShape = CAShapeLayer()
        //        rectShape.bounds = self.bounds
        //        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii:cornerRadii).cgPath
        self.layer.mask = rectShape
    }
    func makeCornerEdge(cornerRadius:CGFloat) {
           self.layer.cornerRadius = cornerRadius
           self.clipsToBounds = true
       }
       
   
    // add bottom border view
    func bottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // Success Toast
    func showSuccessMessage(message: String) {
        let success = MessageView.viewFromNib(layout: .messageView)
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        success.configureTheme(.success)
        success.titleLabel?.isHidden = true
        success.button?.isHidden = true
        success.configureContent(body: message)
        SwiftMessages.show(config: config, view: success)
    }
    
    // Error Toast
    func showErrorMessage(message: String) {
        let error = MessageView.viewFromNib(layout: .messageView)
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        error.configureTheme(.error)
        error.titleLabel?.isHidden = true
        error.button?.isHidden = true
        error.configureContent(body: message)
        SwiftMessages.show(config: config, view: error)
    }
    
    // Warning Toast
    func showWarningMessage(message: String) {
        let warning = MessageView.viewFromNib(layout: .messageView)
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        warning.configureTheme(.warning)
        warning.titleLabel?.isHidden = true
        warning.button?.isHidden = true
        warning.configureContent(body: message)
        SwiftMessages.show(config: config, view: warning)
    }
    
    // Informative Toast
    func showInformativeMessage(message: String) {
        let info = MessageView.viewFromNib(layout: .messageView)
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        info.configureTheme(.info)
        info.titleLabel?.isHidden = true
        info.button?.isHidden = true
        info.configureContent(body: message)
        SwiftMessages.show(config: config, view: info)
    }
    
    // show loading overlay over current view
    func showLoading(message:String = "") {
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        HUD.show(.progress)
    }
    
    // dissmiss loading view from current view
    func dissmissLoading (isSuccess:Bool = true) {
        HUD.hide()
    }
    
    // Footer loading view
    func showFooterLoadingView() {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = false
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        lbl.text = "LOADING...".localized;
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.gray
        lbl.textAlignment = .center
        lbl.sizeToFit()
        lbl.center = self.center
        self.addSubview(lbl)
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.center = CGPoint(x: lbl.frame.origin.x - 30, y: self.frame.size.height/2)
        self.addSubview(spinner)
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}

// for getting start & end month date
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

// for removing particular string from complte string
extension String {
    mutating func replace(_ originalString:String, with newString:String) {
        self = self.replacingOccurrences(of: originalString, with: newString)
    }
}
extension UIButton {
    func set(fontSize: CGFloat) {
        if let titleLabel = titleLabel {
            titleLabel.font = UIFont(name: titleLabel.font.fontName, size: fontSize)
        }
    }
    
    func makeRounded(borderWidth: CGFloat, borderColor: UIColor,radius:CGFloat){
           self.layer.cornerRadius = radius
           self.clipsToBounds = true
           self.layer.borderWidth = borderWidth
           self.layer.borderColor = borderColor.cgColor
           
       }
}
//print(Date().startOfMonth())     // "2018-02-01 08:00:00 +0000\n"
//print(Date().endOfMonth())       // "2018-02-28 08:00:00 +0000\n"
