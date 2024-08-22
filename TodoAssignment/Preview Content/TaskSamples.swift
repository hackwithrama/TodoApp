//
//  TaskSamples.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import Foundation

extension Task {
    static let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date.now)!
    static let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date.now)!
    static let tomorrow = Date.now.addingTimeInterval(86400 * (1))
    static var sampleTasks: [Task] {
        [
            Task(taskName: "Go to gym", taskDate: nextWeek, isImportant: true),
            Task(taskName: "Take pet to vet", taskDate: nextMonth, isImportant: false),
            Task(taskName: "Service car", taskDate: Date.now, isImportant: true, isCompleted: true),
            Task(taskName: "Buy new phone", taskDate: tomorrow, isImportant: false)
        ]
    }
}
