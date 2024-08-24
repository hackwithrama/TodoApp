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
    @Query private var tasks: [Task]
    
    private var showImp: Bool
    private var filterString: String
    
    init(filterString: String, showImp: Bool){
        
        let predicate = #Predicate<Task>{task in
            task.taskName.localizedStandardContains(filterString) ||
            filterString.isEmpty
        }
        
        let sort: [SortDescriptor<Task>] = [SortDescriptor(\Task.taskDate)]
        
        self.filterString = filterString
        self.showImp = showImp
        _tasks = Query(filter: predicate, sort: sort)
    }
    
    var body: some View {
        Group{
            if tasks.isEmpty{
                ContentUnavailableView("Enter your first task", systemImage: "list.bullet.clipboard.fill")
                    .background(Color.grayLight)
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
                                                    .strikethrough(task.isCompleted ? true : false)
                                                Text(task.taskName)
                                                    .foregroundStyle(.grayDark)
                                                    .font(.title2)
                                                    .strikethrough(task.isCompleted ? true : false)
                                            }
                                            .animation(.linear(duration: 0.5), value: task.isCompleted)
                                            Spacer()
                                            if task.isImportant{
                                                Image(systemName: "bookmark.fill")
                                                    .foregroundStyle(Color.lightRed)
                                            }
                                        }
                                    }
                                    .listRowSeparator(.hidden)
                                }
                                .padding(8)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowBackground(Color.grayLight)
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach{index in
                                let task = tasks[index]
                                context.delete(task)
                            }
                        })
                    }
                    .background(Color.grayLight)
                    .scrollContentBackground(.hidden)
                    // MARK: - Progress bar
                    ProgressiveBar(height: 20, percentage: CGFloat(tasks.filter { $0.isCompleted }.count) / CGFloat(tasks.count) * 100)
                }
                .background(Color.grayLight)
            }
        }
    }
}

#Preview {
    let preview = Preview(Task.self)
    let tasks = Task.sampleTasks
    preview.addExample(tasks)
    return TodoList(filterString: "", showImp: false)
        .modelContainer(preview.container)
}
