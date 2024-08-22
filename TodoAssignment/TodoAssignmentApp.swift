//
//  TodoAssignmentApp.swift
//  TodoAssignment
//
//  Created by Ramachandran Varadaraju on 22/08/24.
//

import SwiftUI
import SwiftData

@main
struct TodoAssignmentApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            TodoListView()
        }
        .modelContainer(container)
    }
    
    init(){
        let schema = Schema([Task.self])
        let config = ModelConfiguration("MyTasks", schema: schema)
        
        do{
            container = try ModelContainer(for: schema, configurations: config)
        }catch{
            fatalError("Could not configure the container")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
