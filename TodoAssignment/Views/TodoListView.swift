//
//  ContentView.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @State private var showAddTodoView: Bool = false
    @State private var isTaskCompleted = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Task.taskDate) private var tasks: [Task]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(tasks){task in
                        NavigationLink{
                            EditTodoView(task: task)
                        }label: {
                            HStack{
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .imageScale(.large)
                                    .foregroundStyle(task.isCompleted ? .green : .primary)
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        task.taskCompletedDate = task.isCompleted ? Date.now : nil
                                    }
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(task.taskDate, format: .dateTime.day().month().year().hour().minute())
                                            .font(.footnote)
                                        Text(task.taskName)
                                            .strikethrough(task.isCompleted ? true : false)
                                    }
                                    Spacer()
                                    if task.isImportant{
                                        Image(systemName: "bookmark.fill")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                        }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach{index in
                        let task = tasks[index]
                        context.delete(task)
                    }
                })
            }
            .listStyle(.plain)
            .navigationTitle("ToDo")
            .toolbar{
                Button{
                    print("Book")
                }label:{
                    Image(systemName: "bookmark.fill")
                        .foregroundStyle(.red)
                }
                
                Button{
                    showAddTodoView.toggle()
                }label: {
                    Image(systemName: "plus.circle.fill")
                }
                .sheet(isPresented: $showAddTodoView){
                    AddTodoView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(32)
                }
            }
        }
    }
}

#Preview {
    TodoListView()
        .modelContainer(for: Task.self, inMemory: true)
}
