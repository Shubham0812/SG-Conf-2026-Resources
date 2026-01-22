//
//  CurrentProgressView.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 15/05/25.
//

import SwiftUI

struct CurrentProgressView: View {
    
    // MARK: - Variables
    @Environment(MainViewModel.self) var mainViewModel
    @Environment(\.colorScheme) var colorScheme

    @Binding var viewAppeared: Bool
    
    var foregroundColor: Color = .yellow
    
    let animationDuration: TimeInterval = 0.35
    
    // MARK: - Views
    var body: some View {
        VStack {
            HStack {
                Text("Current Progress")
                    .font(ClashGrotestk.medium.font(size: 15))
                
                Spacer()
                
                HStack {
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text("\(mainViewModel.user.earnedXP) XP")
                        .foregroundStyle(foregroundColor)
                        .brightness(-0.1)
                        .font(ClashGrotestk.semibold.font(size: 16))
                }
            }
            .padding(.horizontal, 2)

            GeometryReader { proxy in
                let width: CGFloat = proxy.size.width - 4
                RoundedRectangle(cornerRadius: 12)
                    .opacity(0.075)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.quizPurple)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1.5)
                            }
                            .frame(width: !viewAppeared ? 0 : width * mainViewModel.user.currentProgress)
                            .animation(.smooth(duration: animationDuration * 2), value: viewAppeared)
                            .padding(1.25)
                    }
            }
            .frame(height: 18)
        }
    }
}

#Preview {
    CurrentProgressView(viewAppeared: .constant(true))
        .environment(MainViewModel())
        .padding(12)
}
