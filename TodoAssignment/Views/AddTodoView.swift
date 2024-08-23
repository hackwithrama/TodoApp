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
            VStack {
                GroupBox(label: Label("Add", systemImage: "plus.circle.fill").foregroundStyle(Color.grayDark).font(.title3)){
                    
                    TextField("Task", text: $taskName)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .foregroundStyle(.primary)
                        .padding(.vertical, 10)
                    
                    LabeledContent{
                        DatePicker("", selection: $taskDate, in: Date.now..., displayedComponents: [.date,.hourAndMinute])
                    }label: {
                        Text("Select date")
                    }
                    .padding(.bottom, 20)
                    
                    LabeledContent{
                        Toggle("", isOn: $isImportant)
                    }label: {
                        Label("Important", systemImage: isImportant ? "bookmark.fill" : "bookmark.slash")
                            .foregroundStyle(isImportant ? .red : .primary)
                    }
                    .padding(.bottom, 5)
                    
                    Button{
                        let newTask = Task(taskName: taskName, taskDate: taskDate, isImportant: isImportant)
                        context.insert(newTask)
                        dismiss()
                    }label: {
                        Text("Create")
                    }
                    .padding(.vertical, 5)
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .disabled(taskName.isEmpty == true)
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
