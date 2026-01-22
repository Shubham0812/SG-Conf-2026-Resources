//
//  DayCell.swift
//  ToDo_UI
//
//  Created by Shubham on 12/01/26.
//

import SwiftUI

struct DayCell: View {
    let date: Date
    let task: [Task]
    let isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundColor(isSelected ? .background : Color.label)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .topLeading)
//                .contentTransition(.numericText())

            // Colored blocks for transactions
            if !task.isEmpty {
                HStack(spacing: 2) {
                    ForEach(task.prefix(3)) { t in
                        Rectangle()
                            .fill(!t.completed ? Color.label : Color.green)
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(4)
            }
        }
        .frame(height: 45)
        .background(isSelected ? Color.label : Color.background)
        .overlay(Rectangle().stroke(Color.label, lineWidth: 1))
    }
}

#Preview {
    DayCell(date: Date(), task: [], isSelected: true)
        .padding(12)
}
