//
//  String.swift
//  UniksApp
//
//  Created by jonathan fragoso on 12/07/2017.
//  Copyright © 2017 Uniks. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // email validation
    public var validEmail:Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // password validation
    public var validPassword:Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    // Base64 data to string
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    // Base64 data to string
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    // provide localized string for key
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    //insert placeholder text in between string
    mutating func replacePlaceholders(_ vals: [String: Any]) -> String {
        for (placeholderName, val) in vals {
            self = self.replacingOccurrences(of: "{{\(placeholderName)}}", with: val as! String)
        }
        return self
    }
    
    // replace string with string
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    // provide height of text
    func calculateHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    // provide width of text
    func calculateWidth(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    //Checks if the string contains a whitespace
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.count
    }
    
// left menu 
}


    extension String {
        func lastPathComponent(withExtension: Bool = true) -> String {
            let lpc = self.nsString.lastPathComponent
            return withExtension ? lpc : lpc.nsString.deletingPathExtension
        }

        var nsString: NSString {
             return NSString(string: self)
        }
    }
/*
    let path = "/very/long/path/to/filename_v123.456.plist"
    let filename = path.lastPathComponent(withExtension: false)
    filename constant now contains "filename_v123.456"
 */


extension String {

    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }

    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
    
   
}

/*
 let file = "image.png"
 let fileNameWithoutExtension = file.fileName()
 let fileExtension = file.fileExtension()
 */


