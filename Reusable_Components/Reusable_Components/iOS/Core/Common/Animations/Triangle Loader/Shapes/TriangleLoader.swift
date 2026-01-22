//
//  TriangleLoader.swift
//  Reusable_Components
//
//  Created by Shubham on 22/01/26.
//

import SwiftUI

struct TriangleLoader: View {
    
    // MARK: - Variables
    @State var strokeStart: CGFloat = 0
    @State var strokeEnd: CGFloat = 0
    
    @State var circleOffset: CGSize = CGSize(width: 0, height: 0)
    
    let animationDuration: TimeInterval = 0.7
    var circleColor: Color = Color.blue
    
    
    // MARK: - Views
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            ZStack {
                TriangleShape()
                    .trim(from: strokeStart, to: strokeEnd)
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 8))
                Circle()
                    .offset(circleOffset)
                    .foregroundColor(circleColor)
                    .frame(width: 15, height: 15)
            }
            .frame(width: 100, height: 100)
            .offset(y: -75) // bring it a little bit up
        }
        .onAppear() {
            setStroke(state: .begin)
            setCircleOffset(state: .begin)
            animate()
            
            Timer.scheduledTimer(withTimeInterval: animationDuration * 4.5, repeats: true) { _ in
                animate()
            }
        }
    }
    
    // MARK: - Functions
    func animate() {
        Timer.scheduledTimer(withTimeInterval: animationDuration / 2, repeats: false) { _ in
            withAnimation(.easeInOut(duration: animationDuration)) {
                setStroke(state: .phaseOne)
            }
            
            withAnimation(.spring(response: animationDuration * 2, dampingFraction: 0.85)) {
                setCircleOffset(state: .phaseOne)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 2 , repeats: false) { _ in
            withAnimation(.easeInOut(duration: animationDuration)) {
                setStroke(state: .phaseTwo)
            }
            
            withAnimation(.spring(response: animationDuration * 2, dampingFraction: 0.85)) {
                setCircleOffset(state: .phaseTwo)
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 3.5, repeats: false) { _ in
            setStroke(state: .stop)
            
            withAnimation(.easeInOut(duration: animationDuration)) {
                setStroke(state: .begin)
            }
            
            withAnimation(.spring(response: animationDuration * 2, dampingFraction: 0.85)) {
                setCircleOffset(state: .begin)
            }
        }
    }
    
    func setStroke(state: TriangleState) {
        (self.strokeStart, self.strokeEnd) = state.getStrokes()
    }
    
    func setCircleOffset(state: TriangleState) {
        let offset = state.getCircleOffset()
        self.circleOffset = CGSize(width: offset.0, height: offset.1)
    }
}

#Preview {
    TriangleLoader()
}
