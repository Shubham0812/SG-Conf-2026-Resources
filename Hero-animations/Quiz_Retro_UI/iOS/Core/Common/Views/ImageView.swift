//
//  ImageView.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 15/05/25.
//

import SwiftUI

struct ImageView: View {
    
    // MARK: - variables
    @Environment(MainViewModel.self) var mainViewModel
    
    var imageName: String = "shubham-s"
    var size: CGFloat = 80
    
    var needsAnimation: Bool = true
    
    // MARK: - views
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .scaleEffect(1.5, anchor: .top)
                .clipShape(Circle())
                .frame(width: size, height: size)
        }
    }
}

#Preview {
    ImageView()
        .environment(MainViewModel())
}
