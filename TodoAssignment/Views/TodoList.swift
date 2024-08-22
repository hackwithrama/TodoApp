//
//  TodoList.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import SwiftUI
import SwiftData

struct TodoList: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Task.taskDate) private var tasks: [Task]
    
    @Binding var showImp: Bool
    
    var body: some View {
        Group{
            if tasks.isEmpty{
                ContentUnavailableView("Enter your first task", systemImage: "list.bullet.clipboard.fill")
            }else{
                VStack {
                    List{
                        ForEach(showImp ? tasks.filter{$0.isImportant} : tasks){task in
                                NavigationLink{
                                    EditTodoView(task: task)
                                }label: {
                                    HStack{
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .imageScale(.large)
                                            .foregroundStyle(task.isCompleted ? .grayDark : .grayMedium)
                                            .onTapGesture {
                                                task.isCompleted.toggle()
                                                task.taskCompletedDate = task.isCompleted ? Date.now : nil
                                            }
                                        HStack{
                                            VStack(alignment: .leading){
                                                Text(task.taskDate, format: .dateTime.day().month().year().hour().minute())
                                                    .font(.footnote)
                                                    .foregroundStyle(.secondary)
                                                Text(task.taskName)
                                                    .foregroundStyle(.grayDark)
                                                    .font(.title2)
                                                    .strikethrough(task.isCompleted ? true : false)
                                            }
                                            Spacer()
                                            if task.isImportant{
                                                Image(systemName: "bookmark.fill")
                                                    .foregroundStyle(Color.lightRed)
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
                    // MARK: - Progress bar
                    ProgressiveBar(height: 20, percentage: CGFloat(tasks.filter { $0.isCompleted }.count) / CGFloat(tasks.count) * 100)
                }
            }
        }
    }
}

#Preview {
    TodoList(showImp: .constant(false))
}
