//
//  ImageView.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

struct ImageView: View {
    
    // MARK: - Variables
    @State var userImage = "thumb"
    
    var size: CGFloat = 56
    var needsAnimation: Bool = true
    
    
    // MARK: - Views
    var body: some View {
        Image(userImage)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(.circle)
            .background {
                Circle()
                    .foregroundStyle(.clear)
            }
    }
}

#Preview {
    ImageView(size: 72)
}
