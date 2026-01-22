//
//  TickShape.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

struct Tick: Shape {
    let scaleFactor: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let cX = rect.midX + 1
        let cY = rect.midY
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.move(to: CGPoint(x: cX - (42 * scaleFactor), y: cY - (4 * scaleFactor)))
        path.addLine(to: CGPoint(x: cX - (scaleFactor * 18), y: cY + (scaleFactor * 28)))
        path.addLine(to: CGPoint(x: cX + (scaleFactor * 40), y: cY - (scaleFactor * 36)))
        
        return path
    }
}


#Preview {
    Tick(scaleFactor: 1)
        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
}
