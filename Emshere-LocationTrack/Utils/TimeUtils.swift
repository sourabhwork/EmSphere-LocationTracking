//
//  TimeUtils.swift
//  SampleCode
//
//  Created by iarianatech mac-mini on 20/12/17.
//  Copyright © 2017 iAriana Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

/*
 1. All the date/Time formation code goes here.
 */

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
    case dayWithDate = "EEEE dd-MMM-yyyy"
    case shortmonthYear = "MMM yyyy"
    case dateMonth = "dd MMM"
    //case discrepanciesDateTime = "dd MMM yyyy hh:mm:ss"

}

extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {
    
    func toDate(format: Format) -> Date? {
        return DateFormatter(format: format.rawValue).date(from: self)
    }
    
    func toDateString(inputFormat: Format, outputFormat: Format) -> String? {
        if let date = toDate(format: inputFormat) {
            return DateFormatter(format: outputFormat.rawValue).string(from: date)
        }
        return nil
    }
}

extension Date {

    var timeStamp: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
    // timestamp to date
    static func convertFromTimestamp(_ fromTimestamp: Double?) -> Date? {
        guard let timestamp = fromTimestamp else {
            return nil
        }
        return Date(timeIntervalSince1970: timestamp)
    }
    
    // string to date
    static func convertFromString(format: Format, dateStr: String?, timezone: TimeZone? = nil) -> Date? {
        guard let val = dateStr else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = timezone != nil ? timezone : TimeZone.current
        
        return formatter.date(from: val)
    }
    
    // date to string
    func toString(format: Format, timezone: TimeZone? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = timezone != nil ? timezone : TimeZone.current
        
        return formatter.string(from: self)
    }

    func getMonthYear(format: Format, timezone: TimeZone? = nil) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = timezone != nil ? timezone : TimeZone.current

        let strDate = formatter.string(from: self)
        return strDate.toDate(format: format)!
    }

    //count between  date
    func printCountBtnTwoDates(mStartDate: Date, mEndDate: Date) -> Int {
        print(mStartDate)
         print(mEndDate)
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: mStartDate)
        let date2 = calendar.startOfDay(for: mEndDate)

        let flags = Calendar.Component.day
        let components = calendar.compare(date2, to: date1, toGranularity: flags)

        print(components.rawValue)
        return 1
    }
    
    func getMaximumPickerDate() -> Date? {
        return (Calendar.current as NSCalendar).date(byAdding: .year, value: -14, to: Date(), options: [])!
    }
    
    func getFirstDateOfCurrentYear() -> Date? {
        let components = Calendar.current.dateComponents([.year], from: Date())
        return Calendar.current.date(from: components)
    }

    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }

    func getPreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }

    func getNextDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    func getSixthDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 5, to: self)
    }
    
    func getPreviousDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)
    }
    
    // get relative time from date
    var relativeTime:String {
        
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        
        return "Just now"
    }
}
