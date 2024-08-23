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
    
    init(filterString: String, showImp: Binding<Bool>){
        
//        let predicate = #Predicate<Task>{task in
//            task.taskName.localizedStandardContains(filterString) ||
//            filterString.isEmpty
//        }
        
        self.filterString = filterString
        self._showImp = showImp
//        _tasks = Query(filter: predicate, sort: \Task.taskDate)
    }
    
    @Binding var showImp: Bool
    private var filterString: String
    
    var body: some View {
        let filteredTasks = tasks.filter { task in
                    (task.taskName.localizedStandardContains(filterString) || filterString.isEmpty) &&
                    (!showImp || task.isImportant)
                }
        
        Group{
            if filteredTasks.isEmpty{
                ContentUnavailableView("Enter your first task", systemImage: "list.bullet.clipboard.fill")
                    .background(Color.grayLight)
            }else{
                VStack {
                    List{
                        ForEach(filteredTasks){task in
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
                                let task = filteredTasks[index]
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

//#Preview {
//    TodoList(showImp: .constant(false))
//}
