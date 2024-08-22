//
//  TodoModel.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import Foundation
import SwiftData

@Model
class Task{
    var taskName: String
    var taskDate: Date
    var isImportant: Bool
    var isCompleted: Bool
    var taskCompletedDate: Date?
    
    init(
        taskName: String,
        taskDate: Date,
        isImportant: Bool,
        isCompleted: Bool = false,
        taskCompletedDate: Date? = nil
    ) {
        self.taskName = taskName
        self.taskDate = taskDate
        self.isImportant = isImportant
        self.isCompleted = isCompleted
        self.taskCompletedDate = taskCompletedDate
    }
}
