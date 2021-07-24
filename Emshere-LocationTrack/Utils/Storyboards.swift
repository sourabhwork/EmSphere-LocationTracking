//
//  Storyboards.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 20/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    //Main
    static func Main() -> UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    //Home
     static func Home() -> UIStoryboard {
        return UIStoryboard(name:"Home", bundle: Bundle.main)
    }
    
    //Attandance
    static func Attandance() -> UIStoryboard {
        return UIStoryboard(name:"Attandance", bundle: Bundle.main)
    }

    //CustomPopup
    static func CustomPopup() -> UIStoryboard {
        return UIStoryboard(name:"CustomPopup", bundle: Bundle.main)
    }


    // Location
    static func Locations() -> UIStoryboard {
        return UIStoryboard(name:"Locations", bundle: Bundle.main)
    }
    //ApplicationStatus
    static func ApplicationStatus() -> UIStoryboard {
        return UIStoryboard(name:"ApplicationStatus", bundle: Bundle.main)
    }

    // AttedanceReports.storyboard
    static func AttedanceReports() -> UIStoryboard {
        return UIStoryboard(name:"AttedanceReports", bundle: Bundle.main)
    }

   // ApplicationApprovals

    static func ApplicationApprovals() -> UIStoryboard {
        return UIStoryboard(name:"ApplicationApprovals", bundle: Bundle.main)
    }

    // shift Allocation
    static func ShiftAllocation() -> UIStoryboard {
        return UIStoryboard(name:"ShiftAllocation", bundle: Bundle.main)
    }
    //alerts
    static func Alerts() -> UIStoryboard {
        return UIStoryboard(name:"Alerts", bundle: Bundle.main)
    }
    
    //alerts
    static func Settings() -> UIStoryboard {
        return UIStoryboard(name:"Settings", bundle: Bundle.main)
    }
}
