//
//  TaskRowView.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

struct TaskRowView: View {
    
    // MARK: - variables
    @Environment(TaskManager.self) var taskManager
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var viewOffset: CGFloat = 2
    @State var deleteOpacity: Double = 0
    
    @ObservedObject var task: Task
    
    var index: Int = 0
    
    let dragOffset: CGFloat = 30
    let deleteOffset: CGFloat = -40
    let resetOffset: CGFloat = 2

    let animationDuration: TimeInterval = 0.35
    let characterLimit: Int = 30
    
    let width: CGFloat = UIScreen.main.bounds.width
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                let translation = value.translation
                let isHorizontalSwipe = abs(translation.height) < dragOffset
                
                guard isHorizontalSwipe else { return }
                
                let isSwipeLeft = translation.width < 0
                
                withAnimation(.easeOut(duration: animationDuration)) {
                    if isSwipeLeft {
                        viewOffset = deleteOffset
                        deleteOpacity = 1
                    } else {
                        viewOffset = resetOffset
                        deleteOpacity = 0
                    }
                }
            }
    }
    
    // MARK: - Views
    var body: some View {
        ZStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.backgroundNeu)
                    .overlay {
                        HStack(spacing: 12) {
                            Button(action: {
                                task.completed.toggle()
                                try! viewContext.save()  // This triggers FetchRequest refresh
                            }) {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundColor(task.completed ? Color.green
                                                         : Color.gray.opacity(0.5))
                                        .animation(.smooth, value: task.completed)
                                        .frame(width: 34, height: 34)
                                    
                                    Tick(scaleFactor: 0.2)
                                        .trim(from: 0, to: task.completed ? 1 : 0)
                                        .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                        .foregroundColor(Color.white)
                                        .frame(width: 24, height: 24)
                                        .opacity(task.completed ? 1 : 0)
                                        .animation(.snappy, value: task.completed)
                                }
                            }
                            Text(task.name ?? "")
                                .font(Montserrat.medium.font(size: 20))
                                .colorMultiply(task.completed ? Color.green : Color.label)
                                .animation(Animation.smooth(duration: 0.3).delay(0.05), value: task.completed)
                                .onTapGesture {
                                    task.completed.toggle()
                                    try? viewContext.save()
                                }
                                .overlay(alignment: .leading) {
                                    Rectangle()
                                        .stroke(lineWidth: 1.5)
                                        .frame(width: task.completed ? .none : 0, height: 1)
                                        .opacity(task.completed ? 1 : 0)
                                        .animation(.smooth, value: task.completed)
                                }
                                .padding(.leading, 8)
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }
            }
            .offset(x: viewOffset)
            
            HStack {
                Spacer()
                Button(action: {
                    taskManager.deleteTask(task: task, context: viewContext)
                    self.deleteOpacity = 0
                    
                    withAnimation(.smooth) {
                        viewOffset = -width
                    }
                }) {
                    Image(systemName: "multiply")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.red)
                }
                .opacity(deleteOpacity)
            }
        }
        .simultaneousGesture(dragGesture)
    }
}

#Preview {
    TaskRowView(task: Task(taskName: "Demo", date: Date(), completionStatus: false, context: PersistenceController.shared.container.viewContext))
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environment(TaskManager())
        .frame(height: 52)
        .padding(24)
}
