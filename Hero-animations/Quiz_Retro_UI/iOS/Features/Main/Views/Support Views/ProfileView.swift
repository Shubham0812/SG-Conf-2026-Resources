//
//  ProfileView.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 15/05/25.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Variables
    @Environment(MainViewModel.self) var mainViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var viewAppeared = false
    @State var rotateAura = false
    
    let animation: Namespace.ID
    let frameSize: CGFloat = 80
    
    let animationDuration: TimeInterval = 0.4
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .top) {
            Color.quizBackground
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ImageView(size: frameSize, needsAnimation: false)
                        .environment(mainViewModel)
                        .background {
                            Circle()
                                .foregroundStyle(.white)
                        }
                        .frame(width: frameSize, height: frameSize)
                        .matchedGeometryEffect(id: "shubham", in: animation)
                    
                    Text(mainViewModel.user.name.components(separatedBy: " ")[0])
                        .font(ClashGrotestk.semibold.font(size: 26))
                        .tracking(1.1)
                        .padding(.top, 12)
                        .offset(y: viewAppeared ? 0 : -24)
                        .opacity(viewAppeared ? 1 : 0)
                        .animation(.snappy(duration: 0.25).delay(0.2), value: viewAppeared)
                    
                    Text("@\(mainViewModel.user.username)")
                        .font(ClashGrotestk.regular.font(size: 18))
                        .padding(.top, -9)
                        .opacity(0.7)
                        .offset(y: viewAppeared ? 0 : -24)
                        .opacity(viewAppeared ? 1 : 0)
                        .animation(.snappy(duration: 0.25).delay(0.25), value: viewAppeared)
                    
                    
                    CurrentProgressView(viewAppeared: $viewAppeared, foregroundColor: .label)
                        .matchedGeometryEffect(id: "progressBar", in: animation)
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                    
                    RoundedRectangle(cornerRadius: 42)
                        .foregroundStyle(.background)
                        .frame(height: 800)
                        .padding(.bottom, -34)
                        .overlay(alignment: .top) {
                            VStack(alignment: .leading) {
                                
                                RoundedRectangle(cornerRadius: 24)
                                    .foregroundStyle(.quizYellow)
                                    .overlay(alignment: .topLeading) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text("\(mainViewModel.user.streaksCount.appendZeros())")
                                                    .font(Montserrat.semibold.font(size: 64))
                                                
                                                Text("Days Streak")
                                                    .font(ClashGrotestk.medium.font(size: 16))
                                                    .opacity(0.8)
                                            }
                                            Spacer()
                                            
                                            HStack(spacing: 48) {
                                                Image("streak")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .scaleEffect(0.825)
                                            }
                                        }
                                        .padding(.horizontal, 24)
                                    }
                                    .frame(height: 124)
                                
                                Text("Recent Achievement(s)")
                                    .font(ClashGrotestk.semibold.font(size: 20))
                                    .tracking(1.05)
                                    .padding(.top, 32)
                                
                                VStack(spacing: -8) {
                                    Image(.level10)
                                        .resizable()
                                        .frame(width: 230, height: 230)
                                        .background {
                                            Image(.sunburst)
                                                .resizable()
                                                .scaledToFill()
                                                .scaleEffect(1.1)
                                                .rotationEffect(rotateAura ? .degrees(360) : .zero)
                                        }
                                    
                                    Text("You solved 10 Quizzes. You're an expert!")
                                        .font(Montserrat.medium.font(size: 19))
                                        .opacity(0.9)
                                        .tracking(0.15)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                        }
                        .padding(.top, 24)
                        .offset(y: viewAppeared ? 0 : UIScreen.main.bounds.height * 0.5)
                        .animation(.smooth(duration: 0.75), value: viewAppeared)
                }
                .padding(.top, 72)
            }
        }
        .overlay(alignment: .topTrailing) {
            Image(systemName: "multiply")
                .font(.system(size: 22, weight: .regular))
                .padding(16)
                .background {
                    Circle()
                        .stroke(lineWidth: 1.25)
                }
                .contentShape(.circle)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        mainViewModel.profileOpened = false
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 24)
        }
        .onAppear() {
            viewAppeared.toggle()
            
            withAnimation(.linear(duration: 40).repeatForever()) {
                rotateAura = true
            }
        }
    }
}

#Preview {
    ProfileView(animation: Namespace().wrappedValue)
        .environment(MainViewModel())
}
