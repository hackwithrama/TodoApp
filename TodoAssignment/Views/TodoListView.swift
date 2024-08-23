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
    @State private var showImportantOnly = false
    @State private var filterTaskByName = ""
    
    var body: some View {
        NavigationStack{
            TodoList(filterString: filterTaskByName, showImp: $showImportantOnly)
            .searchable(text: $filterTaskByName, prompt: "Filter task by name")
            .navigationTitle("ToDo")
            .animation(.easeOut(duration: 2), value: showImportantOnly)
            .animation(.easeOut(duration: 2), value: filterTaskByName)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showImportantOnly.toggle()
                    }label:{
                        Image(systemName: showImportantOnly ? "bookmark.fill" : "bookmark.slash")
                            .font(.title3)
                            .foregroundStyle(Color.lightRed)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showAddTodoView.toggle()
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.grayDark)
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
}

#Preview {
    TodoListView()
        .modelContainer(for: Task.self, inMemory: true)
}
