//
//  FontManager.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

enum Nocturne {
    case regular
    case medium
    case semibold
    case bold
    
    func font(size: CGFloat) -> Font {
        switch self {
        case .regular:
            return .custom("NocturneSerif-Regular", size: size)
        case .medium:
            return .custom("NocturneSerif-Medium", size: size)
        case .semibold:
            return .custom("NocturneSerif-SemiBold", size: size)
        case .bold:
            return .custom("NocturneSerif-Bold", size: size)
            
        }
    }
}


enum Montserrat {
    case regular
    case medium
    case semibold
    case bold
    
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
    
    // MARK: - Functions
    func getUIFont(size: CGFloat) -> UIFont {
        switch self {
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: size)!
        case .medium:
            return UIFont(name: "Montserrat-Medium", size: size)!
        case .semibold:
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: size)!
        }
    }
}
