//
//  PairController.swift
//  Pair
//
//  Created by Devin Flora on 2/12/21.
//

import CoreData

class PairController {
    
    // MARK: - Properties
    static let shared = PairController()
    var sections: [[Person]] {[assignedUsers]}
    var assignedUsers: [Person] = []
    var unassignedUsers: [Person] = []
    
    var fetchRequest: NSFetchRequest<Person> = {
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD Methods
    func createUserWith(name: String) {
        let newPerson = Person(name: name)
        unassignedUsers.append(newPerson)
        CoreDataStack.saveContext()
    }
    
    func fetchPeople() {
        let persons = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        unassignedUsers = persons
    }
    
    func delete(person: Person) {
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
    }
    
    func randomizeUsers() {
        assignedUsers = []
        let shuffledUsers = unassignedUsers.shuffled()
        assignedUsers.append(contentsOf: shuffledUsers)
        print(assignedUsers)
        CoreDataStack.saveContext()
    }
}//End of Class
