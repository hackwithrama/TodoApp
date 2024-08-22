//
//  EditTodoView.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import SwiftUI

struct EditTodoView: View {
    @Environment(\.dismiss) private var dismiss
    let task: Task
    @State private var taskName = ""
    @State private var taskDate = Date.now
    @State private var isImportant = false
    @State private var isCompleted = false
    
    var changed: Bool{
        taskName != task.taskName
        || taskDate != task.taskDate
        || isCompleted != task.isCompleted
        || isImportant != task.isImportant
    }
    
    var body: some View {
        VStack{
            GroupBox{
                TextField("Task", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .foregroundStyle(.primary)
                LabeledContent{
                    DatePicker("", selection: $taskDate, in: Date.now..., displayedComponents: [.date,.hourAndMinute])
                }label: {
                    Text("Complete by")
                }
                .disabled(isCompleted)
                LabeledContent{
                    Toggle("", isOn: $isImportant)
                }label: {
                    Label("Important", systemImage: isImportant ? "bookmark.fill" : "bookmark.slash")
                        .foregroundStyle(isImportant ? .red : .primary)
                        .imageScale(.large)
                }
                LabeledContent{
                    Toggle("", isOn: $isCompleted)
                }label: {
                    Label("Completed", systemImage: isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundStyle(isCompleted ? .green : .primary)
                        .imageScale(.large)
                }
                Button("Update"){
                    task.taskName = taskName
                    task.taskDate = taskDate
                    task.isCompleted = isCompleted
                    task.isImportant = isImportant
                    dismiss()
                }
                .disabled(!changed)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Edit task")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            taskName = task.taskName
            taskDate = task.taskDate
            isCompleted = task.isCompleted
            isImportant = task.isImportant
        }
    }
}

#Preview {
    NavigationStack {
        EditTodoView(task: Task(taskName: "Service car", taskDate: Date.now, isImportant: true, isCompleted: true))
    }
}
