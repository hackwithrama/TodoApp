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
            GroupBox(label: Label("Edit", systemImage: "pencil.circle.fill").foregroundStyle(Color.grayDark).font(.title3)){
                
                TextField("Task", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .foregroundStyle(.primary)
                    .padding(.vertical, 10)
                
                LabeledContent{
                    DatePicker("", selection: $taskDate, in: Date.now..., displayedComponents: [.date,.hourAndMinute])
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
