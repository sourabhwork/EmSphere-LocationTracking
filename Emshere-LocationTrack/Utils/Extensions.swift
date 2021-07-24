//
//  Extensions.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 20/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

/*
 1. All the Common custom function/extensions goes here.
 */

// return device iphone or ipad
public var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone
}

protocol OptionalType {
    associatedtype Wrapped
    func intoOptional() -> Wrapped?
}

extension Optional : OptionalType {
    func intoOptional() -> Wrapped? {
        return self
    }
}

extension Dictionary where Value: OptionalType {
    func filterNil() -> [Key: Value.Wrapped] {
        var result: [Key: Value.Wrapped] = [:]
        for (key, value) in self {
            if let unwrappedValue = value.intoOptional() {
                result[key] = unwrappedValue
            }
        }
        return result
    }
    
    /// A dictionary wrapper that unwraps optional values in the dictionary literal
    /// that it's created with.
    struct ValueUnwrappingLiteral : ExpressibleByDictionaryLiteral {
        
        typealias WrappedValue = Dictionary.Value
        
        fileprivate let base: [Key : WrappedValue]
        
        init(dictionaryLiteral elements: (Key, WrappedValue?)...) {
            
            var base = [Key : WrappedValue]()
            
            // iterate through the literal's elements, unwrapping the values,
            // and updating the base dictionary with them.
            for case let (key, value?) in elements {
                
                if base.updateValue(value, forKey: key) != nil {
                    // duplicate keys are not permitted.
                    fatalError("Dictionary literal may not contain duplicate keys")
                }
            }
            
            self.base = base
        }
    }
    
    init(unwrappingValues literal: ValueUnwrappingLiteral) {
        self = literal.base // simply get the base of the unwrapping literal.
    }
}

extension CGFloat {
    // return random number
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension Date {

}

extension GMSMarker {
    
    func setCustomMarkerView(marker: GMSMarker , img : UIImageView) {
        let pulsev = UIView.init(frame: CGRect(x:0,y:0, width: 50, height: 50))
        pulsev.layer.cornerRadius = pulsev.frame.size.height / 2
        pulsev.layer.masksToBounds = true
        pulsev.backgroundColor = UIColor.clear
        
        let annotationImage = UIView.init(frame: CGRect(x: ((pulsev.frame.size.width) - 50)/2,y: ((pulsev.frame.size.height) - 50)/2, width: 50, height: 50))
        annotationImage.backgroundColor = UIColor.init(patternImage: UIImage.init(named:"redpin1.png")!)
        
        var imageView = UIImageView.init(frame: CGRect(x: 10,y: 5, width: 30, height: 30))
        imageView.layer.masksToBounds = true
        // imageView.image = UIImage.init(named: img as String)
        imageView = img;
        
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        annotationImage.addSubview(imageView)
        //pulsev.addSubview(pulseView)
        pulsev.addSubview(annotationImage)
        marker.iconView = pulsev
        
    }
}

//return application BundleShortVersion
public var getBundleShortVersion: String {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    let build = dictionary["CFBundleVersion"] as! String
    
    #if ENV_DEV
        return "\(version)-Debug (\(build))"
    #else
        return "\(version)-Release (\(build))"
    #endif
}

// return device country name
public var getDeviceLocaleCountryName: String {
    let countryCode: String = Locale.current.regionCode!
    let currentLocale : NSLocale = NSLocale.init(localeIdentifier :  NSLocale.current.identifier)
    let countryName : String? = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
    print(countryName ?? "Invalid country code")
    return countryName!
}


extension CAShapeLayer {
    
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
    
}

private var handle: UInt8 = 0;

extension UIBarButtonItem {
    
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    func setBadge(text: String?, withOffsetFromTopRight offset: CGPoint = CGPoint.zero, andColor color:UIColor = #colorLiteral(red: 0.9633457065, green: 0.6807981133, blue: 0.2581744492, alpha: 1), andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11) {
        badgeLayer?.removeFromSuperlayer()
        
        if (text == nil || text == "") {
            return
        }
        
        addBadge(text: text!, withOffset: offset, andColor: color, andFilled: filled)
    }
    
    private func addBadge(text: String, withOffset offset: CGPoint = CGPoint.zero, andColor color: UIColor = UIColor.white, andFilled filled: Bool = true, andFontSize fontSize: CGFloat = 11) {
        guard let view = self.customView else { return }
        
        var font = UIFont.systemFont(ofSize: fontSize)
        
        if #available(iOS 9.0, *) {
            font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
        }
        
        let badgeSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        //initialize Badge
        let badge = CAShapeLayer()
        
        let height = badgeSize.height;
        var width = badgeSize.width + 2 /* padding */
        
        //make sure we have at least a circle
        if (width < height) {
            width = height
        }
        
        //x position is offset from right-hand side
        let x = width - offset.x//view.frame.width - width + offset.x
        
        let badgeFrame = CGRect(origin: CGPoint(x: x, y: offset.y), size: CGSize(width: width, height: height))
        
        badge.drawRoundedRect(rect: badgeFrame, andColor: color, filled: filled)
        view.layer.addSublayer(badge)
        
        //initialiaze Badge's label
        let label = CATextLayer()
        label.string = text
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.font = font
        label.fontSize = font.pointSize
        
        label.frame = badgeFrame
        label.foregroundColor = filled ? UIColor.white.cgColor : color.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        //save Badge as UIBarButtonItem property
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        //bring layer to front
        badge.zPosition = 1000
    }
    
    private func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }
    
}

extension UIViewController {
    func flipTheView(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                    }
                }
                flipTheView(subviews: subView.subviews)
            }
        }
    }
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

