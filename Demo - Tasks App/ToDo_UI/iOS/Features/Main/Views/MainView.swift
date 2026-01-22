//
//  ContentView.swift
//  ToDo_UI
//
//  Created by Shubham on 11/11/24.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Variables
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var mainViewModel: MainViewModel = .init()
    @State var taskManager: TaskManager = .init()
    
    @FetchRequest var fetchRequest: FetchedResults<Task>
    
    @State var viewAppeared = false
    
    let animationDuration: TimeInterval = 0.325
    
    
    init() {
        // Initialize the @FetchRequest with the predicate and sort descriptors
        _fetchRequest = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)],
            predicate: nil,
            animation: .smooth(duration: 0.5)
        )
    }
    
    // MARK: - Views
    var body: some View {
        GeometryReader { proxy in
            let width: CGFloat = proxy.size.width - 52
            
            ZStack(alignment: .topLeading) {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            CalendarView()
                            .opacity(self.viewAppeared ? 0.75 : 0)
                            .offset(x: self.viewAppeared ? 0 : -24)
                            .animation(.smooth(duration: 0.35), value: viewAppeared)
                        }
                        VStack(alignment: .leading) {
                            TopBarView(viewAppeared: $viewAppeared)
                            
                            TaskListView(selectedDate: mainViewModel.selectedDate, viewAppeared: $viewAppeared, width: width)
                        }
                        .padding(.top, 12)
                        .opacity(!mainViewModel.showCalendars ? 1 : 0.4)
                    }
                    .safeAreaPadding(.top, 12)
                    .padding(.trailing, 24)
                    .safeAreaPadding(.leading, 24)
                    
                    // padding at the bottom
                    Spacer()
                        .frame(height: 100)
                }
            }
        }
        .overlay {
            Color.label
                .ignoresSafeArea()
                .opacity(mainViewModel.addTask ? 0.5 : 0)
        }
        .overlay(alignment: .bottom) {
            TaskAddingView()
                .colorInvert()
                .frame(height: 320)
                .offset(y: !mainViewModel.addTask ? 280 : 0)
        }
        .environment(mainViewModel)
        .environment(taskManager)
        .onAppear() {
            viewAppeared.toggle()
        }
    }
    
    // MARK: - Functions
    
    @ViewBuilder
    func CalendarView() -> some View {
        HStack {
            Button {
                withAnimation(.smooth) {
                    mainViewModel.showCalendars.toggle()
                }
            } label: {
                HStack {
                    Text(mainViewModel.selectedDate.day + "  " + mainViewModel.selectedDate.month)
                        .contentTransition(.numericText())
                    
                        .font(Nocturne.semibold.font(size: 18))
                }
                .padding(8)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 0.8)
                }
                .gesture(calendarSwipeGesture())
                .animation(.snappy, value: mainViewModel.selectedDate)
            }
            .buttonStyle(.plain)
        }
    }
    
    func calendarSwipeGesture() -> some Gesture {
        let dragOffset: CGFloat = 44
        let minSwipeDistance: CGFloat = 20
        
        return DragGesture(minimumDistance: minSwipeDistance, coordinateSpace: .local)
            .onEnded { value in
                let translation = value.translation
                let isHorizontalSwipe = abs(translation.height) < dragOffset
                
                guard isHorizontalSwipe else { return }
                
                let shouldIncrement = translation.width < 0
                
                withAnimation(.smooth) {
                    mainViewModel.adjustDate(increment: shouldIncrement)
                }
            }
    }
}

#Preview {
    MainView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
