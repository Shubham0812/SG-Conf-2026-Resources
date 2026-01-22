//
//  ColorExtensions.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 13/05/25.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        self.init(UIColor(hex: hex))
    }
}

extension UIColor {
    /// For converting Hex-based colors
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(red: Double, green: Double, blue: Double) {
        let red: Double = red
        let green: Double = green
        let blue: Double = blue
        
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0, alpha: 1.0)
    }
    
}




extension Color {
    func toRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red, green, blue, alpha)
        }
        return nil
    }

    func toHex() -> String? {
        guard let rgb = toRGB() else { return nil }
        let r = Int(rgb.red * 255)
        let g = Int(rgb.green * 255)
        let b = Int(rgb.blue * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
