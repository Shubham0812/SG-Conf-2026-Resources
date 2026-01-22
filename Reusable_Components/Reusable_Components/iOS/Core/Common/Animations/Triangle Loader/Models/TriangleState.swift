//
//  TriangleState.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

enum TriangleState {
    case begin
    case phaseOne
    case phaseTwo
    case stop
    
    func getStrokes() -> (CGFloat, CGFloat) {
        switch self {
        case .begin:
            return (0.335, 0.665)
        case .phaseOne:
            return (0.5, 0.825)
        case .phaseTwo:
            return (0.675, 1)
        case .stop:
            return (0.175, 0.5)
        }
    }
    
    func getCircleOffset() -> (CGFloat, CGFloat) {
        switch self {
        /// you'll have to change the offset values here if you want to increase/decrease the size of the circle
        case .begin:
            return (0, 35)
        case .phaseOne:
            return (30, -5)
        case .phaseTwo:
            return (-30, -5)
        case .stop:
            return (-30, 0)
        }
    }
}
