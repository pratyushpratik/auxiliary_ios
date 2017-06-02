//
//  DateTimeManager.swift
//
//  Created by Pratyush Pratik on 01/02/17.
//  Copyright © 2017 Code Brew. All rights reserved.
//

import UIKit
import Foundation

struct BookingDate {
    
    var day : Int?
    var weekday : String?
    var month : String?
    var year : Int?
    var date : Date?
    
    var formattedDate : String? {
        get {
            return "\(/month) \(/day),\(/year)"
        }
    }
}

let weekdays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Satudrday"
]

let arrayMonth = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
]

class DateTimeManager {
    
    static let shared : DateTimeManager = {
        let instance = DateTimeManager()
        return instance
    }()
    
    
    
    var timestamp : String {
        return "\(Date().timeIntervalSince1970 * 1000)"
    }
    
    var localTimeZoneName: String { return TimeZone.current.identifier }
    
    var localTimeZoneAbbreviation: String { return /TimeZone.current.abbreviation() }
    
    var timeZoneAbbreviations: [String:String] { return TimeZone.abbreviationDictionary }
    
    var timeZoneIdentifiers: [String] { return TimeZone.knownTimeZoneIdentifiers }
    
    var currentMonth : String? {
        
        let todayDate = Date()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let month = calendar.component(.month, from: todayDate)
        
        let dateFormatter: DateFormatter = DateFormatter()
        let monthSymbol = arrayMonth[month-1]
        return monthSymbol
    }
    
    func previousFewDays(count : Int) -> [BookingDate] {
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var dates = [BookingDate]()
        dates.append(makeBookingDate(date: date))
        
        for _ in 1 ... count - 1 {
            date = cal.date(byAdding: .day, value: -1, to: date) ?? Date()
            dates.append(makeBookingDate(date: date))
        }
        return dates
    }
    
    func nextPreviousFewDays(count : Int) -> [BookingDate] {
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var dates = [BookingDate]()
        dates.append(makeBookingDate(date: date))
        
        for _ in 1 ... count - 1 {
            date = cal.date(byAdding: .day, value: -1, to: date) ?? Date()
            dates.append(makeBookingDate(date: date))
        }
        
        date = cal.startOfDay(for: Date())
        for _ in 1 ... count - 1 {
            date = cal.date(byAdding: .day, value: 1, to: date) ?? Date()
            dates.append(makeBookingDate(date: date))
        }
        dates.sort { $0.date ?? Date() < $1.date ?? Date() }
        return dates
    }
    
    func nextFewDays(count : Int) -> [BookingDate] {
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var dates = [BookingDate]()
        dates.append(makeBookingDate(date: date))
        
        for _ in 1 ... count - 1 {
            date = cal.date(byAdding: .day, value: 1, to: date) ?? Date()
            dates.append(makeBookingDate(date: date))
        }
        return dates
    }
    
    func nextDay(count : Int) -> BookingDate {
        
        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        date = cal.date(byAdding: .day, value: count, to: date) ?? Date()
        return makeBookingDate(date: date)
    }
    
    func makeBookingDate(date : Date) -> BookingDate {
        
        let cal = Calendar.current
        let day = cal.component(.day, from: date)
        let month = cal.component(.month, from: date)
        let year = cal.component(.year, from: date)
        let monthStr = arrayMonth[month - 1]
        let weekday = toString(from: date, usingFormat: DateFormat.ee.rawValue)
        return BookingDate(day: day, weekday: weekday, month: monthStr, year: year, date: date)
    }
    
    func convertDateComponentToDateString(component : DateComponents?, usingFormat format : String) -> String {
        
        if let theComponent = component {
            let calendar = Calendar.current
            if let date = calendar.date(from: theComponent) {
                let convertDateStr = self.toString(from: date, usingFormat: format)
                return convertDateStr
            }
        }
        return String()
    }
    
    func to24Time(from date : String?) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: /date)
        
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date ?? Date())
    }
    
    func toString(from date: Date?, usingFormat format : String) -> String {
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let formattedDate : String = dateFormatter.string(from: date ?? Date())
        return formattedDate
    }
    
    func toUTCDate(from dateStr : String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.utc.rawValue
        var dateToReturn : Date = Date()
        if let date : Date = dateFormatter.date(from: dateStr) {
            dateToReturn = date
        }
        return dateToReturn
    }
    
    func toStringFromCurrentDate(usingFormat format : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format // superset of OP's format
        let dateStr = dateFormatter.string(from: Date())
        return dateStr
    }
    
    func toDateFromCurrentDate(usingFormat format : String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format // superset of OP's format
        let dateStr = dateFormatter.string(from: Date())
        let date = self.toDate(from: dateStr, usingFormat: format)
        return date
    }
    
    func toDate(from date : Date?, usingFormat format : String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateStr = dateFormatter.string(from: date ?? Date())
        let date = self.toDate(from: dateStr, usingFormat: format)
        return date
    }
    
    //    func toUTCString(from date : Date) -> String {
    //
    //        let dateFormatter = DateFormatter()
    //        let tempLocale = dateFormatter.locale // save locale temporarily
    //        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    //        dateFormatter.dateFormat = DateFormat.utc.rawValue
    //        let date = dateFormatter.string(from: date)
    //        dateFormatter.dateFormat = DateFormat.utc.rawValue
    //        dateFormatter.locale = tempLocale
    //        let newUtc = dateFormatter.string(from: date)
    //        return newUtc
    //    }
    
    func toUTC(from date : Date?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddHHmmss.rawValue // superset of OP's format
        return dateFormatter.string(from: date ?? Date())
    }
    
    /*********************** Fetching Current Date ************************/
    func date(_value: Int?) -> (_string: String, _date: Date) {
        let today = Date()
        let date = Calendar.current.date(byAdding: .day, value: /_value, to: today)
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.EEMMMMddyyyy.rV
        let result = formatter.string(from: /date)
        let dateResult = formatter.date(from: result)
        print(/dateResult)
        return (/result, /dateResult)
    }
    
    func toDate(from dateString : String?,usingFormat format : String) -> Date? {
        
        guard let validDateStr = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: validDateStr)
        return date
    }
    
    func toDate(fromTime timeString : String, usingFormat format : String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        var dateToReturn : Date = Date()
        if let date : Date = dateFormatter.date(from: timeString) {
            dateToReturn = date
        }
        return dateToReturn
    }
    
    func toHourMins(from secondString : TimeInterval) -> (Int, Int, Int) {
        let seconds : Int = Int (secondString)
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func dayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = DateFormat.yyyyMMdd.rawValue
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekdays[weekDay-1]
    }
    
    func perform(calendar : Calendar,fromDate: Date?, toDate: Date?) -> Int? {
        
        guard let validFromDate = fromDate, let validEndDate = toDate else { return nil }
        let difference = calendar.dateComponents([.day], from: validFromDate, to: validEndDate)
        return difference.day
    }
    
    func timeAgoString(fromDate date: Date) -> String? {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute], from: date, to: now)
        
        if (components.year ?? 0) > 0 {
            formatter.allowedUnits = .year
        } else if (components.month ?? 0) > 0 {
            formatter.allowedUnits = .month
        } else if (components.weekOfMonth ?? 0) > 0 {
            formatter.allowedUnits = .weekOfMonth
        } else if (components.day ?? 0) > 0 {
            formatter.allowedUnits = .day
        } else if (components.hour ?? 0) > 0 {
            formatter.allowedUnits = .hour
        } else if (components.minute ?? 0) > 0 {
            formatter.allowedUnits = .minute
        } else {
            formatter.allowedUnits = .second
        }
        
        let formatString = NSLocalizedString("%@ ago", comment: "Used to say how much time has passed. e.g. '2 hours ago'")
        
        guard let timeString = formatter.string(from: components) else {
            return nil
        }
        return String(format: formatString, timeString)
    }
    
    var currentTimeZoneOffset : Int {
        
        let timeZone = TimeZone.current
        let offsetTime = TimeInterval(timeZone.secondsFromGMT())
        return Int(offsetTime/60.0)
    }
}

extension Date {
    
    init?(jsonDate: String) {
        let prefix = ""
        let suffix = ""
        let scanner = Scanner(string: jsonDate)
        
        // Check prefix:
        guard scanner.scanString(prefix, into: nil)  else { return nil }
        
        // Read milliseconds part:
        var milliseconds : Int64 = 0
        guard scanner.scanInt64(&milliseconds) else { return nil }
        // Milliseconds to seconds:
        var timeStamp = TimeInterval(milliseconds)/1000.0
        
        // Read optional timezone part:
        var timeZoneOffset : Int = 0
        if scanner.scanInt(&timeZoneOffset) {
            let hours = timeZoneOffset / 100
            let minutes = timeZoneOffset % 100
            // Adjust timestamp according to timezone:
            timeStamp += TimeInterval(3600 * hours + 60 * minutes)
        }
        
        // Check suffix:
        guard scanner.scanString(suffix, into: nil) else { return nil }
        
        // Success! Create NSDate and return.
        self.init(timeIntervalSince1970: timeStamp)
    }
}
