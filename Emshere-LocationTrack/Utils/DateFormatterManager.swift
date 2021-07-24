//
//  DateFormatterManager.swift
//  emSphere
//
//  Created by Dhiraj Chaudhari on 03/07/18.
//  Copyright © 2018 Dhiraj Chaudhari. All rights reserved.
//

import UIKit

class DateFormatterManager: NSObject {

  static let sharedInstance = DateFormatterManager()

    enum Format: String {
        case date = "yyyy-MM-dd HH:mm:ss"
        case onlyYear = "yyyy"
        case birthday = "dd-MMM-yyyy"
        case fbBirthday = "MM/dd/yyyy"
        case month = "MMMM"
        case monthDate = "MMM,dd"
        case graphDate = "yyyy-MM-dd"
        case monthYear = "MMMM yyyy"
        case time = "HH:MM"
        case TwelveHourtime = "hh:mm a"
        case shiftDate = "dd-MMM-yyyy hh:mm a"
        case punchDate = "dd-MMM-yyyy hh:mm:ss"
        case compOffAgFullDate = "dd MMM yyyy HH:mm:ss"
        case compOffAgCellDate = "dd MMM yyyy"
        case compOffShortFullCellDate = "dd MMM yy"
        //case discrepanciesDateTime = "dd MMM yyyy hh:mm:ss"

    }
    func dateFormatedString(dateString:String?,inputFormat:String?,outputFormat:String?)-> String? {
        var formattedDate = ""
        //let string = "December 20, 2016"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = inputFormat

        if let date = formatter.date(from: dateString!) {
            print(date)  // "2016-12-20 02:00:00 +0000\n"
            formatter.dateFormat = outputFormat
            formattedDate = formatter.string(from: date)   // "12/20/16"
            return formattedDate
        }
        return formattedDate
    }

    func dateFormatedString2(dateString:String?,inputFormat:Format,outputFormat:Format)-> String? {
        var formattedDate = ""
        //let string = "December 20, 2016"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = inputFormat.rawValue

        if let date = formatter.date(from: dateString!) {
            print(date)  // "2016-12-20 02:00:00 +0000\n"
            formatter.dateFormat = outputFormat.rawValue
            formattedDate = formatter.string(from: date)   // "12/20/16"
            return formattedDate
        }
        return formattedDate
    }



}
