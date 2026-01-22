//
//  TaskAddingView.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI

struct TaskAddingView: View {
    
    // MARK: - Variables
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(MainViewModel.self) var mainViewModel
    @Environment(TaskManager.self) var taskManager
    
    @State var taskName = ""
    @State var isPriority = false
    
    @State var viewAppeared: Bool = false
    
    let animationDuraiton: TimeInterval = 0.35
    
    // MARK: - Views
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                        .frame(width: 44, height: 44)
                    
                    Spacer()
                    
                    Text(mainViewModel.addTask ? "New Task" : "Add Task")
                        .font(Nocturne.bold.font(size: 28))
                        .frame(minWidth: 100, minHeight: 30)
                        .contentTransition(.numericText())
                        .opacity(mainViewModel.addTask ? 1 : 0.9)
                    Spacer()
                    
                    Button {
                        withAnimation(.smooth(duration: animationDuraiton)) {
                            mainViewModel.addTask.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .rotationEffect(mainViewModel.addTask ? .degrees(45) : .zero)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                    }
                    .opacity(mainViewModel.addTask ? 1 : 0.7)
                    .buttonStyle(.plain)
                    .frame(width: 44, height: 44)
                }
                
                Text("Task Name")
                    .font(Nocturne.semibold.font(size: 19))
                    .padding(.top, 32)
                
                CustomTextFieldView(toBindValue: $taskName, viewAppeared: $viewAppeared, placeHolder: "Enter Task Here *")
                    .padding(.top, 2)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation(.smooth) {
                            taskManager.addTask(name: taskName, selectedDate: mainViewModel.selectedDate, context: viewContext)
                            mainViewModel.addTask.toggle()
                            taskName = ""
                        }
                        UIApplication.shared.endEditing()
                    } label: {
                        Text("Add Task")
                            .font(Montserrat.semibold.font(size: 22))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .disabled(taskName.isEmpty ? true : false)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .opacity(taskName.isEmpty ? 0.4 : 1)
                    }
                    .animation(.smooth, value: taskName)
                    .buttonStyle(.plain)
                    .frame(height: 52)
                    Spacer()
                }
            }
            .padding(18)
            .padding(.horizontal, 8)
            .onAppear() {
                viewAppeared = true
            }
        }
    }
}

#Preview {
    VStack {
        
        TaskAddingView()
            .environment(MainViewModel())
            .environment(TaskManager())
            .colorInvert()
            .frame(height: 350)
    }
    
}
