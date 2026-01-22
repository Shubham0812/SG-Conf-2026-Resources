//
//  MainViewModel.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

@Observable
class MainViewModel {
    
    // MARK: - Variables
    
    var selectedMonth: String = Date.now.month
    var selectedYear: String = Date.now.year
    
    var selectedMonthYear = ""
    var selectedDaysOfMonth: CalendarMonth?
    
    var showCalendars = false
    
    var selectedDate: Date = Date.now {
        didSet {
            self.selectedMonth = selectedDate.month
            self.selectedYear = selectedDate.year
            
            self.displayDate = Constants.displayDateFormatter.string(from: selectedDate)
        }
    }
    
    var addTask = false
    
    var displayDate = ""
    
    var greeting: String = {
        let date = Date()
        guard let hour = Int(Constants.hourFormatter.string(from: date)) else { return "Hello" }
        
        if (hour > 0 && hour < 12) {
            return "Good Morning,"
        } else if (hour >= 12 && hour < 16) {
            return "Good Afternoon,"
        } else {
            return "Good Evening,"
        }
    }()
    
    // MARK: - Inits
    init(forTest: Bool = false) {
        
    }
    
    
    
    // MARK: - Functions
}


extension MainViewModel {
    func adjustDate(increment: Bool = false) {
        var date = self.selectedDate
        
        var dateComponents = DateComponents()
        dateComponents.day = increment ? 1 : -1
        
        if let adjustedDate = Calendar.current.date(byAdding: dateComponents, to: date) {
            self.selectedDate = adjustedDate
        } else {
            self.selectedDate = Date()
        }
    }
    
    
    func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: selectedDate) {
            selectedDate = newDate
        }
    }
    
    func daysInMonth(for date: Date) -> [Date?] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = calendar.date(from: components)!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        for i in 0..<numDays {
            if let d = calendar.date(byAdding: .day, value: i, to: firstDayOfMonth) {
                days.append(d)
            }
        }
        return days
    }
    
    func isSameDay(_ date1: Date?, _ date2: Date) -> Bool {
        guard let d1 = date1 else { return false }
        return Calendar.current.isDate(d1, inSameDayAs: date2)
    }
    
    func isSameMonth(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, equalTo: date2, toGranularity: .month)
    }
}
