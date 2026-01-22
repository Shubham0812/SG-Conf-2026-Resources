//
//  Animator.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

enum AnimationDuration {
    case fast       // 0.2
    case medium     // 0.3
    case slow       // 0.4
    case custom(Double)
    
    var value: Double {
        switch self {
        case .fast:
            return 0.2
        case .medium:
            return 0.3
        case .slow:
            return 0.4
        case .custom(let d):
            return d
        }
    }
}

enum Animator {
    case standard
    case enter
    case exit
    case emphasis
    case tap
    case smooth
    
    func animation(duration: AnimationDuration = .medium) -> Animation {
        switch self {
            
        case .standard:
            return .easeInOut(duration: duration.value)
            
        case .enter:
            return .easeOut(duration: duration.value)
            
        case .exit:
            return .easeIn(duration: duration.value)
            
        case .emphasis:
            return .easeInOut(duration: duration.value)
            
        case .smooth:
            return .smooth(duration: duration.value)
            
        case .tap:
            // duration is intentionally ignored for spring-based feedback
            return .interactiveSpring(
                response: 0.25,
                dampingFraction: 0.75
            )
        }
    }
}
