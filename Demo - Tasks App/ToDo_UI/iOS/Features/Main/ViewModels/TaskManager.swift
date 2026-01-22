//
//  TaskViewModel.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import SwiftUI
import CoreData

@Observable
class TaskManager {
    
    // MARK: - Inits
    init(forTest: Bool = false) {
        
    }
    
    
    // MARK: - Functions
    func addTask(name: String, selectedDate: Date, context: NSManagedObjectContext) {
        let newTask = Task(context: context)
        newTask.id = UUID().uuidString
        newTask.name = name
        newTask.date = selectedDate
        newTask.completed = false

        saveContext(context)
    }
    
    func updateTask(task: Task, newName: String, context: NSManagedObjectContext) {
        task.name = newName
        saveContext(context)
    }
    
//    func toggleTaskStatus(task: Task, context: NSManagedObjectContext) {
//        task.completed.toggle()
//        saveContext(context)
//    }


    func deleteTask(task: Task, context: NSManagedObjectContext) {
        context.delete(task)
        saveContext(context)
    }
    
    
    // MARK: - Utility Functions
    private func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data context: \(error)")
        }
    }
}
