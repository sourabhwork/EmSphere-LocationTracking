//
//  Font.swift
//  GoldenSpoon
//
//  Created by kalpesh on 01/02/18.
//  Copyright © 2018 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

class Font {
    // App Fonts
    /*
     <string>roboto-condensed.light.ttf</string>
     <string>roboto-condensed.regular.ttf</string>
     <string>roboto.black.ttf</string>
     <string>roboto.light.ttf</string>
     <string>roboto.medium.ttf</string>
     <string>roboto.regular.ttf</string>
     <string>roboto.thin.ttf</string>
 */

    static var  appBoldFont: String {
        return "roboto.black"
    }

    static var  appMediumFont: String {
        return "roboto.medium"
    }

    static var  appRegularFont: String {
        return "roboto.regular"
    }

    static var  appLightFont: String {
        return "roboto.light"
    }


    static var  appThinFont: String {
        return "roboto.thin"
    }
    
    static var  appBlackFont: String {
        return "roboto.black"
    }

    static var  appCondensedLight: String {
        return "roboto-condensed.light"
    }

    static var  appCondensedRegular: String {
        return "roboto-condensed.regular"
    }
    
    
    static let headerMediumSize = UIFont(name: Font.appMediumFont, size: 18.0)!
    static let headerBoldSize = UIFont(name: Font.appBoldFont, size: 18.0)!
    static let headerRegularSize = UIFont(name: Font.appRegularFont, size: 18.0)!
    
    static let buttonBoldSize = UIFont(name: Font.appBoldFont, size: 16.0)!
    static let buttonMediumSize = UIFont(name: Font.appMediumFont, size: 16.0)!
    static let buttonRegularSize = UIFont(name: Font.appRegularFont, size: 16.0)!
    
    static let titleBoldSize = UIFont(name: Font.appBoldFont, size: 15.0)!
    static let titleMediumSize = UIFont(name: Font.appMediumFont, size: 15.0)!
    static let titleRegularSize = UIFont(name: Font.appRegularFont, size: 15.0)!
    
    static let subTitleBoldSize = UIFont(name: Font.appBoldFont, size: 14.0)!
    static let subTitleMediumSize = UIFont(name: Font.appMediumFont, size: 14.0)!
    
    static let subTitleRegularSize = UIFont(name: Font.appRegularFont, size: 14.0)!
    
    static let captionRegularSize = UIFont(name: Font.appRegularFont, size: 12.0)!
}
