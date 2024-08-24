import Foundation
import SwiftData

struct Preview{
    let container: ModelContainer
    
    init(_ models: any PersistentModel.Type...){
        let schema = Schema(models)
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do{
            container = try ModelContainer(for: schema, configurations: config)
        }catch{
            fatalError("Failed to configure preview container")
        }
    }
    
    @MainActor
    func addExample(_ examples: [Task]){
            examples.forEach{example in
                container.mainContext.insert(example)
            }
    }
}
