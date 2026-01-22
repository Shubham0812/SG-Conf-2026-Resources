//
//  ViewExtensions.swift
//  ToDo_UI
//
//  Created by Shubham on 12/01/26.
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
