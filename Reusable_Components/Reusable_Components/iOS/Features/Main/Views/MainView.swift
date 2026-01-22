//
//  MainView.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    @State private var viewModel = MainViewModel()
    
    
    // MARK: - Views
    var body: some View {
        ZStack {
            VStack {
                Text("Hello, World!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MainView()
}
