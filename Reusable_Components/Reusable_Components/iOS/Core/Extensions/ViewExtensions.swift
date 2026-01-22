//
//  ViewExtensions.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
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
            
        case .trailing:
            xOffset = hasAppeared ? 0 : distance
            yOffset = 0
            
        case .top:
            xOffset = 0
            yOffset = hasAppeared ? 0 : -distance
            
        case .bottom:
            xOffset = 0
            yOffset = hasAppeared ? 0 : distance
        }
        
        return self
            .offset(x: xOffset, y: yOffset)
            .opacity(hasAppeared ? 1 : 0)
            .animation(Animator.standard.animation(), value: hasAppeared)
    }
}
