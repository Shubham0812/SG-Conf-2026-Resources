//
//  Constants.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

struct Constants {
    static let darkOpacity: CGFloat = 0.7
    
    static var dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter
    }()
    
    static var displayDateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "dd MMM"
        
        return dateFormatter
    }()
    
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return formatter
    }()
}

