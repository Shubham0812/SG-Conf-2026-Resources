//
//  ScalingButton.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

struct ScalingButton<Label: View>: View {
    let action: () -> Void
    let label: Label
    let scaleAmount: CGFloat
    let animation: Animation
    
    @State private var isPressed = false
    
    init(
        scaleAmount: CGFloat = 0.94,
        animation: Animation = .spring(response: 0.3, dampingFraction: 0.6),
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.scaleAmount = scaleAmount
        self.animation = animation
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        label
            .scaleEffect(isPressed ? scaleAmount : 1)
            .animation(animation, value: isPressed)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(Animator.tap.animation()) {
                    isPressed = true
                }
                action()
                
                Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { _ in
                    withAnimation(Animator.smooth.animation(duration: .fast)) {
                        isPressed = false
                    }
                }
                
            }
    }
}


#Preview {
    ScalingButton(scaleAmount: 0.9, animation: .bouncy) {
        print("Tapped!")
    } label: {
        Text("Press Me")
    }
}
