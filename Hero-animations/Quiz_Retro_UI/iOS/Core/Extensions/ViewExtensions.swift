//
//  ViewExtensions.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 13/05/25.
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
