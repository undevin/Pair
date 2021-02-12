//
//  CoreDataStack.swift
//  Pair
//
//  Created by Devin Flora on 2/12/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Pair")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent store; \(error)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }
    
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}

