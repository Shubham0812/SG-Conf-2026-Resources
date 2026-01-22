//
//  FriendsScrollView.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 15/05/25.
//

import SwiftUI

struct FriendsScrollView: View {
    
    // MARK: - Variables
    @Environment(MainViewModel.self) var mainViewModel
    @Binding var viewAppeared: Bool
    
    let frameSize: CGFloat = 58
    
    // MARK: - Views
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Array(zip(mainViewModel.friends.indices, mainViewModel.friends)), id: \.0) { ix, friend in
                    Circle()
                        .foregroundStyle(friend.color.opacity(0.2))
                        .overlay {
                            Image(friend.name)
                                .resizable()
                                .scaledToFill()
                                .offset(x: -4, y: 14)
                                .scaleEffect(1.5)
                                .clipShape(Circle())
                        }
                        .frame(width: frameSize, height: frameSize)
                        .offset(x: viewAppeared ? 0 : 60 * CGFloat(ix + 1))
                        .opacity(viewAppeared ? 1 : 0)
                        .animation(.snappy(duration: 0.3).delay(0.125 + Double(ix) * 0.025), value: viewAppeared)
                }
            }
        }
    }
}

#Preview {
    FriendsScrollView(viewAppeared: .constant(true))
        .environment(MainViewModel())
        .padding(24)
}
