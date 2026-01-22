//
//  FoundationExtensions.swift
//  ToDo_UI
//
//  Created by Shubham on 11/11/24.
//

import UIKit

extension Int {
    func appendZeros() -> String {
        if (self < 10) {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
    
    func degreeToRadians() -> CGFloat {
        return  (CGFloat(self) * .pi) / 180
    }
    
    func toPhoneNumber() -> String {
        let stringNumber = String(self)
        return stringNumber.prefix(5) +  "-" + stringNumber.suffix(5)
    }
}

extension Double {
    func clean(places: Int) -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(places)f", self)
    }
}

extension CGFloat {
    func clean(places: Int) -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(places)f", self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
