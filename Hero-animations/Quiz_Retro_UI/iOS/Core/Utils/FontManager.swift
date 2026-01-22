//
//  FontManager.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 13/05/25.
//

import SwiftUI

enum ClashGrotestk {
    case extralight
    case light
    case regular
    case medium
    case semibold
    case bold
    
    // MARK: - Private Font Name
    private var fontName: String {
        switch self {
        case .extralight:
            return "ClashGrotesk-Extralight"
        case .light:
            return "ClashGrotesk-Light"
        case .regular:
            return "ClashGrotesk-Regular"
        case .medium:
            return "ClashGrotesk-Medium"
        case .semibold:
            return "ClashGrotesk-Semibold"
        case .bold:
            return "ClashGrotesk-Bold"
        }
    }
    
    // MARK: - SwiftUI Font
    func font(size: CGFloat) -> Font {
        .custom(fontName, size: size)
    }
    
    // MARK: - UIKit Font
    func uiFont(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: fontName, size: size) else {
            fatalError("Font '\(fontName)' not found. Ensure it's added to the project and Info.plist.")
        }
        return font
    }
}


enum Montserrat {
    case regular
    case medium
    case semibold
    case bold
    
    
    // Private font name mapper
    private var fontName: String {
        switch self {
        case .regular:
            return "Montserrat-Regular"
        case .medium:
            return "Montserrat-Medium"
        case .semibold:
            return "Montserrat-SemiBold"
        case .bold:
            return "Montserrat-Bold"
        }
    }
    
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("Montserrat-Regular", size: size)
        case .medium:
            return .custom("Montserrat-Medium", size: size)
        case .semibold:
            return .custom("Montserrat-SemiBold", size: size)
        case .bold:
            return .custom("Montserrat-Bold", size: size)
        }
    }
    
    
    // UIKit Font
      func uiFont(size: CGFloat) -> UIFont {
          UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
      }

}

