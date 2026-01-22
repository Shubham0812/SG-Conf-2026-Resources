//
//  TopBarView.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

struct TopBarView: View {
    
    // MARK: - variables
    @Environment(MainViewModel.self) var mainViewModel
    @Binding var viewAppeared: Bool
    
    @State var profileScale: CGFloat = 0.3
    @State var profileOpacity: Double = 0
    @State var profileOffset: CGFloat = 48
    
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 7) {
                    Text(mainViewModel.greeting)
                        .font(Nocturne.medium.font(size: 24))
                        .shadow(color: Color.white.opacity(0.5), radius: 1)
                        .opacity(self.viewAppeared ? 0.75 : 0)
                        .offset(x: self.viewAppeared ? 0 : -24)
                        .animation(.smooth(duration: 0.35).delay(0.1), value: viewAppeared)
                    
                    Text("Shubham")
                        .font(Nocturne.bold.font(size: 36))
                        .shadow(color: Color.white.opacity(0.5), radius: 1)
                        .opacity(self.viewAppeared ? 1 : 0)
                        .offset(x: self.viewAppeared ? 0 : -16)
                        .animation(.smooth(duration: 0.35).delay(0.15), value: viewAppeared)
                }
                Spacer()
                
                ImageView(size: 64)
                    .opacity(self.profileOpacity)
                    .scaleEffect(self.profileScale)
            }
            .padding(.top, 8)
            
            .onAppear() {
                withAnimation(.snappy(duration: 0.3).delay(0.15)) {
                    self.profileScale = 1
                    self.profileOpacity = 1
                    self.profileOffset = 0
                }
            }
        }
    }
    

}

#Preview {
    TopBarView(viewAppeared: .constant(true))
        .environment(MainViewModel())
        .padding(24)
}
