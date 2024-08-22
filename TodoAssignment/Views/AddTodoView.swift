//
//  AddTodoView.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var taskName = ""
    @State private var taskDate = Date.now
    @State private var isImportant = false
    
    var body: some View {
        NavigationStack{
            GroupBox{
                TextField("Task", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .foregroundStyle(.primary)
                LabeledContent{
                    DatePicker("", selection: $taskDate, in: Date.now..., displayedComponents: [.date,.hourAndMinute])
                }label: {
                    Text("Select date")
                }
                LabeledContent{
                    Toggle("", isOn: $isImportant)
                }label: {
                    Label("Important", systemImage: isImportant ? "bookmark.fill" : "bookmark.slash")
                        .foregroundStyle(isImportant ? .red : .primary)
                }
                Button("Create"){
                    let newTask = Task(taskName: taskName, taskDate: taskDate, isImportant: isImportant)
                    context.insert(newTask)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Spacer()
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button("Cancel"){
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddTodoView()
}
