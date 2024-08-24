//
//  SimpleEditTodoView.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 24/08/24.
//

import SwiftUI

struct SimpleEditTodoView: View {
    let task: Task
    var body: some View {
        Text(task.taskName)
    }
}

#Preview {
    let preview = Preview(Task.self)
    let tasks = Task.sampleTasks
    preview.addExample(tasks)
    return NavigationStack{
        EditTodoView(task: tasks[0])
            .modelContainer(preview.container)
    }
}
