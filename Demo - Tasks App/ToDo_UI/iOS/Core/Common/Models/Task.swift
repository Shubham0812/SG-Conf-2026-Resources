//
//  Task.swift
//  ToDo_UI
//
//  Created by Shubham on 12/11/24.
//

import CoreData

extension Task {
    convenience init(id: String = UUID().uuidString,
                     taskName: String = "Sample Task",
                     date: Date = Date(),
                     completionStatus: Bool = false,
                     context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = id
        self.name = taskName
        self.date = date
        self.completed = completionStatus
    }
}
