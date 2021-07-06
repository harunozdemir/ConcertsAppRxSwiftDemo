//
//  Date+Extension.swift
//  ConcertsApp
//
//  Created by Harun on 5.07.2021.
//  Copyright © 2021 harun. All rights reserved.
//

import Foundation

enum DateFormatterType: String {
    case dayName = "EEEE"
    case dayNumber = "dd"
    case monthName = "MMM"
    case dayMonthYearDotted = "dd.MM.yyyy"
    case dayMonthDayName = "d MMM EEEE"
    case dayMonthYear = "ddMMyyyy"
    case dayMonthNameYear = "dd MMMM yyyy"
    case dayMonthNameTwoYear = "dd MMM yyyy"
    case yearMonthDayLine = "yyyy-MM-dd"
    case yearMonthDaySlash = "dd/MM/yyyy"
    case dayMonthShortName = "d MMM"
    case dayShortMonthYearCommaShortDayName = "dd MMM yyyy, EE"
    case dayMonthYearTimeDotted = "dd.MM.yyyy HH:mm"
    case yearMonthDayLongLine = "yyyy-MM-dd HH:mm:ss.000000"
    case timeHourMinute = "HH:mm"
    case yearMonthDaytime = "yyyy-MM-dd HH:mm"
    case customFormat = "dd-MM-yyyy HH:mm"
    case yearMonthDayTimeDotted = "yyyy.MM.dd HH:mm"
    case iso = "yyyy-MM-dd'T'HH:mm:ssZ"
    case monthNameWithTime = "dd MMMM HH:mm"
}

extension Date {
    var day: Int {
        return self.components().day ?? 1
    }
    
    var month: Int {
        return self.components().month ?? 1
    }
    
    var year: Int {
        return self.components().year ?? 2018
    }
    
    func dateFormat(with type: DateFormatterType) -> Date {
        let dateFormatter = self.dateFormatter(with: type)
        let dateString = dateFormatter.string(from: self)
        
        return dateFormatter.date(from: dateString) ?? self
    }
    
    func string(with type: DateFormatterType) -> String {
        let dateFormatter = self.dateFormatter(with: type)
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    
    func date(byAdding year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(year: year, month: month, day: day)
        
        return calendar.date(byAdding: dateComponents, to: self) ?? self
    }
    
    func previousDay() -> Date {
        return self.date(byAdding: 0, month: 0, day: -1)
    }
    
    func previousWeek() -> Date {
        return self.date(byAdding: 0, month: 0, day: -7)
    }
    
    func previousMonth() -> Date {
        return self.date(byAdding: 0, month: 1, day: 0)
    }
    
    func nextDay() -> Date {
        return self.date(byAdding: 0, month: 0, day: 1)
    }
    
    func nextWeek() -> Date {
        return self.date(byAdding: 0, month: 0, day: 7)
    }
    
    func nextMonth() -> Date {
        return self.date(byAdding: 0, month: 1, day: 0)
    }
    
    func components() -> DateComponents {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: self)
        
        return components
    }
    
    func dayName() -> String {
        return dateFormatter(with: .dayName).string(from: self)
    }
    
    func monthName() -> String {
        return dateFormatter(with: .monthName).string(from: self)
    }
    
    func dayNumber() -> String {
        return dateFormatter(with: .dayNumber).string(from: self)
    }
    
    private func dateFormatter(with type: DateFormatterType) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter
    }
    
    
    func convertDateFormat(with formatterTo: DateFormatterType, formatterFrom: DateFormatterType, dateString: String) -> String {
        let dateFormatterFrom = DateFormatter()
        dateFormatterFrom.dateFormat = formatterFrom.rawValue
        dateFormatterFrom.timeZone = TimeZone(identifier: "GMT")
        
        let dateFormatterTo = DateFormatter()
        dateFormatterTo.dateFormat = formatterTo.rawValue
        dateFormatterTo.timeZone = TimeZone(identifier: "GMT+3")
        
        let dateStr = dateFormatterTo.string(from: dateFormatterFrom.date(from: dateString) ?? self)
        
        return dateStr
        
        //    var dateFormatter = self.dateFormatter(with: formatterTo)
        //    let date = dateFormatter.date(from: dateString)
        //    dateFormatter = self.dateFormatter(with: formatterFrom)
        //    let timeStamp = dateFormatter.string(from: date!)
        //    return timeStamp
    }
    
    func stringToDate(_ type: DateFormatterType, stringDate: String) -> Date {
        if stringDate.isEmpty {
            return Date()
        }
        let formatter = dateFormatter(with: type)
        
        return formatter.date(from: stringDate) ?? Date()
    }
    
    func dateToString(_ type: DateFormatterType) -> String {
        let dateFormatter = self.dateFormatter(with: type)
        
        return dateFormatter.string(from: self)
    }
    
    func dateToHourString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return dateFormatter.string(from: self)
    }
    
    func isDateInToday(date:Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
        
    }
    
}
