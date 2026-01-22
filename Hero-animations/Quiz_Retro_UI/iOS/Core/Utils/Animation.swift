//
//  Animation.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 18/01/26.
//

import SwiftUI

enum AnimationTiming: Double {
    case fast = 0.2
    case medium = 0.3
    case slow  = 0.4
}

enum Animator {
    case standard
    case tap
    case custom(Animation)
    
    func animation(duration: AnimationTiming = .medium) -> Animation {
        switch self {
            
        case .standard:
            return .easeInOut(duration: duration.rawValue)
            
        case .tap:
            return .snappy(duration: duration.rawValue)
            
        case .custom(let animation):
            return animation
        }
    }
}


struct ScalingButton<Label: View>: View {
    let action: () -> Void
    let label: Label
    let delay: Double
    let scaleAmount: CGFloat
    let animation: Animation
    
    @State private var isPressed = false
    
    init(scaleAmount: CGFloat = 0.92, delay: Double = 0.25,
         animation: Animation = .spring(response: 0.3, dampingFraction: 0.6),
         action: @escaping () -> Void,
         @ViewBuilder label: () -> Label
    ) {
        self.scaleAmount = scaleAmount
        self.delay = delay
        
        self.animation = animation
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        label
            .scaleEffect(isPressed ? scaleAmount : 1)
            .animation(animation, value: isPressed)
            .contentShape(.rect)
            .onTapGesture {
                isPressed = true
                action()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    isPressed = false
                }
            }
    }
}


extension View {
    func slideIn(from edge: Edge, hasAppeared: Bool, distance: CGFloat = 56) -> some View {
        let xOffset: CGFloat
        let yOffset: CGFloat
        
        switch edge {
        case .leading:
            xOffset = hasAppeared ? 0 : -distance
            yOffset = 0
            
        case .top:
            xOffset = 0
            yOffset = hasAppeared ? 0 : -distance
            
        default:
            xOffset = 0
            yOffset = 0
        }
        
        return self
            .offset(x: xOffset, y: yOffset)
            .opacity(hasAppeared ? 1 : 0)
            .animation(Animator.standard.animation(), value: hasAppeared)
    }
}

