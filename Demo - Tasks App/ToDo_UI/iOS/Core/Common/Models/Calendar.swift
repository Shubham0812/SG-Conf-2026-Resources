//
//  CalendarMonth.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import Foundation

@Observable
class CalendarDate: Identifiable {
    var date: Date
    var dateString: String
    var id: String
    
    var currentDate: String
    
    init(date: Date) {
        self.date = date
        self.dateString = date.formatted()
        
        self.id = UUID().uuidString
        self.currentDate = date.day
    }
}


struct CalendarMonth {
    let month: Int
    let year: Int
    
    let days: [CalendarDate]
    
    init(month: Int, year: Int, days: [CalendarDate]) {
        self.month = month
        self.year = year
        self.days = days
    }
}
