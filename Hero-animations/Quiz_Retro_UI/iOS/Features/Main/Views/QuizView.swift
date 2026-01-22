//
//  ContentView.swift
//  Quiz_Retro_UI
//
//  Created by Shubham on 13/05/25.
/// CONTENT BY ``@SHUBHAM_IOSDEV``

import SwiftUI

struct QuizView: View {
    
    // MARK: - Variables
    @Environment(\.colorScheme) var colorScheme
    
    @State var mainViewModel: MainViewModel = .init()
    @State var viewAppeared = false
    
    @Namespace var animation
    
    let animationDuration: TimeInterval = 0.325
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.background
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        ImageView(size: 44, needsAnimation: false)
                            .environment(mainViewModel)
                            .background {
                                Circle()
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 44, height: 44)
                            .matchedGeometryEffect(id: "shubham", in: animation)
                            .onTapGesture {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.smooth(duration: 0.45)) {
                                        mainViewModel.profileOpened = true
                                    }
                                }
                            }
                        
                        Spacer()
                        
                        CurrentProgressView(viewAppeared: $viewAppeared)
                            .matchedGeometryEffect(id: "progressBar", in: animation)
                            .padding(.horizontal, 12)
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bell")
                                .font(.system(size: 20, weight: .medium))
                                .padding(12)
                                .background {
                                    Circle()
                                        .stroke(lineWidth: 1.5)
                                        .overlay(alignment: .topTrailing) {
                                            Circle()
                                                .foregroundStyle(.red)
                                                .frame(width: 10, height: 10)
                                                .padding(3)
                                        }
                                }
                        }
                    }
                    .opacity(viewAppeared ? 1 : 0.3)
                    .offset(x: viewAppeared ? 0 : -24)
                    .animation(.smooth(duration: animationDuration), value: viewAppeared)
                    
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Text("Hi,")
                                .font(ClashGrotestk.medium.font(size: 19))
                                .opacity(0.7)
                            
                            Text("Shubham")
                                .font(ClashGrotestk.semibold.font(size: 19))
                        }
                        .opacity(viewAppeared ? 1 : 0.3)
                        .offset(y: viewAppeared ? 0 : -24)
                        .animation(.smooth(duration: animationDuration), value: viewAppeared)
                        
                        Text("Let's continue a quiz!")
                            .font(ClashGrotestk.bold.font(size: 28))
                            .tracking(1.1)
                            .padding(.top, 12)
                            .opacity(viewAppeared ? 1 : 0)
                            .offset(y: viewAppeared ? 0 : -24)
                            .animation(.smooth(duration: animationDuration).delay(0.1), value: viewAppeared)
                        
                        HStack {
                            Text("My Friends")
                                .font(ClashGrotestk.semibold.font(size: 18))
                                .tracking(1.05)

                        }
                        .padding(.top, 42)
                        .opacity(viewAppeared ? 1 : 0)
                        .offset(y: viewAppeared ? 0 : -24)
                        .animation(.smooth(duration: animationDuration).delay(0.175), value: viewAppeared)
                        
                        
                        FriendsScrollView(viewAppeared: $viewAppeared)
                            .padding(.top, 16)
                            .safeAreaPadding(.trailing, 12)
                            .safeAreaPadding(.leading, 20)
                            .padding(.horizontal, -24)
                        
                    }
                    .padding(.top, 24)

                }
                .environment(mainViewModel)
                .buttonStyle(.plain)
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .onAppear() {
                    viewAppeared.toggle()
                }
            }
            .overlay {
                if mainViewModel.profileOpened {
                    ProfileView(animation: animation)
                        .environment(mainViewModel)
                        .transition(.asymmetric(insertion: .identity, removal: .opacity))
                }
            }
        }
    }
}

#Preview {
    QuizView()
}
