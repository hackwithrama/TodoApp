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
    
    @State private var taskName: String
    @State private var taskDate: Date
    @State private var isImportant: Bool
    @State private var isCompleted: Bool
    
    init(task: Task) {
            self.task = task
            _taskName = State(initialValue: task.taskName)
            _taskDate = State(initialValue: task.taskDate)
            _isImportant = State(initialValue: task.isImportant)
            _isCompleted = State(initialValue: task.isCompleted)
        }
    
    var changed: Bool{
        taskName != task.taskName
        || taskDate != task.taskDate
        || isCompleted != task.isCompleted
        || isImportant != task.isImportant
    }
    
    var body: some View {
        VStack{
            GroupBox(label: Label("Edit", systemImage: "pencil.circle.fill").foregroundStyle(Color.grayDark).font(.title3)){
                
                TextField("Task", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .foregroundStyle(.primary)
                    .padding(.vertical, 10)
                
                LabeledContent{
                    DatePicker("", selection: $taskDate, displayedComponents: [.date, .hourAndMinute])
                }label: {
                    Text("Complete by")
                }
                .disabled(isCompleted)
                .padding(.bottom, 20)
                
                LabeledContent{
                    Toggle("", isOn: $isImportant)
                }label: {
                    Label("Important", systemImage: isImportant ? "bookmark.fill" : "bookmark.slash")
                        .foregroundStyle(isImportant ? .red : .primary)
                        .imageScale(.large)
                }
                .padding(.bottom, 5)
                
                LabeledContent{
                    Toggle("", isOn: $isCompleted)
                }label: {
                    Label("Completed", systemImage: isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        .foregroundStyle(isCompleted ? .green : .primary)
                        .imageScale(.large)
                }
                .padding(.bottom, 5)
                
                Button{
                    task.taskName = taskName
                    task.taskDate = taskDate
                    task.isCompleted = isCompleted
                    task.isImportant = isImportant
                    dismiss()
                }label: {
                    Text("Update")
                }
                .padding(.vertical, 5)
                .disabled(!changed || taskName.isEmpty)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .groupBoxStyle(CustomGroupBoxStyle())
            .overlay{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.grayMedium, lineWidth: 2)
            }
            Spacer()
        }
        .padding()
        .background(.grayLight)
        .navigationTitle("Edit task")
        .navigationBarTitleDisplayMode(.inline)
//        .onAppear{
//            taskName = task.taskName
//            taskDate = task.taskDate
//            isCompleted = task.isCompleted
//            isImportant = task.isImportant
//        }
        
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
