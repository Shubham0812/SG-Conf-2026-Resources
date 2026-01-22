//
//  TaskListView.swift
//  ToDo_UI
//
//  Created by Shubham on 13/11/24.
//

import SwiftUI

struct TaskListView: View {
    
    // MARK: - Variables
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest var currentDayTasks: FetchedResults<Task>
    @FetchRequest var completedDayTasks: FetchedResults<Task>
    
    @Binding var viewAppeared: Bool
    
    var width: CGFloat
    
    var completionPercentage: Double {
        let total = currentDayTasks.count
        return total > 0 ? Double(completedDayTasks.count)
        / Double(total) : 0
    }
    
    // MARK: - Inits
    init(selectedDate: Date, viewAppeared: Binding<Bool>, width: CGFloat) {
        let startOfDay = Calendar.current.startOfDay(for: selectedDate)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? selectedDate
        
        // Create the predicate
        let dayPredicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        let completedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            dayPredicate,
            NSPredicate(format: "completed == YES")
        ])
        
        _currentDayTasks = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)],
            predicate: dayPredicate,
            animation: .smooth(duration: 0.5)
        )
        
        _completedDayTasks = FetchRequest(
            sortDescriptors: [],
            predicate: completedPredicate,
            animation: .smooth(duration: 0.5)
        )
        
        _viewAppeared = viewAppeared
        
        self.width = width
    }
    
    
    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Progress")
                    .font(Montserrat.medium.font(size: 20))
                    .textCase(.uppercase)
                    .opacity(self.viewAppeared ? 0.75 : 0)
                    .opacity(self.viewAppeared ? 1 : 0)
                
                Spacer()
                Text("\((completionPercentage * 100).clean(places: 1))%")
                    .font(Montserrat.bold.font(size: 28))
                    .contentTransition(.numericText())
            }
            .offset(y: viewAppeared ? 0 : -16)
            .opacity(viewAppeared ? 1 : 0)
            .animation(.smooth.delay(0.15), value: viewAppeared)
            .padding(.top, 12)
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .offset(x: 0, y: 3)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color.background)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                }
                
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.label.opacity(0.35))
                    .shadow(color: .label.opacity(0.015), radius: 5)
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: (width) * completionPercentage, alignment: .leading)
                    .foregroundColor(.green)
            }
            .offset(y: viewAppeared ? 0 : -16)
            .opacity(viewAppeared ? 1 : 0)
            .animation(.smooth.delay(0.175), value: viewAppeared)
            
            .frame(height: 10)
            .padding(.top, 0)
            
            HStack {
                Text("Your Tasks")
                    .font(Nocturne.semibold.font(size: 28))
                
                Spacer()
                
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 28, weight: .semibold))
                    .opacity(completionPercentage == 1 ? 1 : 0)
                    .symbolEffect(.wiggle.byLayer, value: completionPercentage == 1)
                    .animation(.smooth, value: completionPercentage)
            }
            .padding(.top, 32)
            .offset(y: viewAppeared ? 0 : -16)
            .opacity(viewAppeared ? 1 : 0)
            .animation(.smooth.delay(0.175), value: viewAppeared)
            
            
            VStack(alignment: .leading, spacing: 14) {
                ForEach(currentDayTasks.enumerated(), id: \.element.objectID) { ix, task in
                    TaskRowView(task: task, index: ix)
                        .frame(height: 56)
                        .opacity(self.viewAppeared ? 1 : 0)
                        .offset(y: self.viewAppeared ? 0 : 45 * Double(ix + 1))
                        .animation(.smooth(duration: 0.35).delay(0.15).delay(0.1 * Double(ix + 1)), value: self.viewAppeared)
                }
            }
            .padding(.top, 12)
            
        }
    }
}

#Preview {
    TaskListView(selectedDate: Date(), viewAppeared: .constant(true), width: UIScreen.main.bounds.width)
        .padding(24)
}
