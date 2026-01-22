//
//  FoundationExtensions.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import UIKit

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
    
    var hasNotch: Bool {
        guard let window = getKeyWindow() else { return false }
        return window.safeAreaInsets.bottom > 0
    }
    
    func getKeyWindow() -> UIWindow? {
        // UIApplication.shared.keyWindow is deprecated From iOS 13.0
        // and as such we'll use filter and CompactMap to fetch the KeyWindow
        return UIApplication.shared.connectedScenes
        // better to have a filter so that it doesn't process background,unttached state
            .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .first(where: { $0.isKeyWindow })
    }
}

protocol ZeroPadConvertible {
    func appendZeros() -> String
}

extension BinaryInteger where Self: ZeroPadConvertible {
    func appendZeros() -> String { String(format: "%02d", Int(self)) }
}

extension BinaryFloatingPoint where Self: ZeroPadConvertible {
    func appendZeros() -> String { String(format: "%02.0f", Double(self)) }
}

extension Int:    ZeroPadConvertible {}
extension Double: ZeroPadConvertible {}


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

extension CGFloat {
    func clean(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
}

extension Double {
    func convert(fromRange: (Double, Double), toRange: (Double, Double)) -> Double {
        var value = self
        value -= fromRange.0
        value /= Double(fromRange.1 - fromRange.0)
        value *= toRange.1 - toRange.0
        value += toRange.0
        return value
    }
    
    func clean(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    
    func convertToInt() -> Int {
        return Int(self)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension Date {
    
    var day: String {
        return "\(Calendar.current.component(.day, from: self))"
    }
    
    var weekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        return "\(Calendar.current.component(.year, from: self))"
    }
}

