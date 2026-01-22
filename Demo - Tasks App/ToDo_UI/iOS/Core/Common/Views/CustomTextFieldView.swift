//
//  CustomTextFieldView.swift
//  ToDo_UI
//
//  Created by Shubham on 13/11/24.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    // MARK: - Variables
    @Binding var toBindValue: String
    @Binding var viewAppeared: Bool
    
    var placeHolder: String = "Card Number"
    var font: Font = Nocturne.semibold.font(size: 18)
    
    var darkOpacity: CGFloat = 1
    var onChangeAction: () -> () = {}
    
    var keyboardType: UIKeyboardType = .alphabet
    
    
    // MARK: - Views
    var body: some View {
        TextField(placeHolder, text: $toBindValue)
            .font(font)
            .disableAutocorrection(true)
            .accentColor(Color.label)
            .keyboardType(keyboardType)
            .frame(height: 52)
            .overlay {
                ZStack {
                    Capsule()
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .opacity(0.25)
                        .frame(height: 0.5)
                        .foregroundColor(.label)
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                        .rotationEffect(.degrees(180))
                        .opacity(0.4)
                        .foregroundColor(.label)
                        .frame(height: 0.5, alignment: .trailing)
                }
                .offset(y: 20)
            }
        
            .offset(y: self.viewAppeared ? 0 : 45)
            .opacity(self.viewAppeared ? 1 : 0)
            .animation(.smooth, value: self.viewAppeared)
            .onChange(of: toBindValue) { oldValue, newValue in
                onChangeAction()
            }
    }
}

#Preview {
    CustomTextFieldView(toBindValue: .constant("4123 2312 1211 2333"), viewAppeared: .constant(true))
        .padding(24)
}
