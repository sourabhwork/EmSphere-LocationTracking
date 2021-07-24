//
//  Notifications.swift
//  UniksApp
//
//  Created by Ramon Pans on 18/07/2017.
//  Copyright © 2017 Uniks. All rights reserved.
//

import Foundation

/*
 1. All the Notification names
 */

extension NSNotification {
    
    class var filterOutUnsolvedAlert: NSNotification.Name {
        return NSNotification.Name("filterOutUnsolvedAlert")
    }
    
    class var filterOutSolvedAlert: NSNotification.Name {
        return NSNotification.Name("filterOutSolvedAlert")
    }
    
    class var refreshWIFISSID: NSNotification.Name {
        return NSNotification.Name("RefreshWI-FISSID")
    }
    
}
