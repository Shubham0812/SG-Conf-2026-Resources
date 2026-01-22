//
//  FoundationExtensions.swift
//  ToDo_UI
//
//  Created by Shubham on 11/11/24.
//

import Foundation

extension Date {
    
    var day: String {
        return "\(Calendar.current.component(.day, from: self))"
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        return "\(Calendar.current.component(.year, from: self))"
    }
}
