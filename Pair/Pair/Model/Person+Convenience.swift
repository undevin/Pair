//
//  Pair+Convenience.swift
//  Pair
//
//  Created by Devin Flora on 2/12/21.
//

import CoreData

extension Person {
    @discardableResult convenience init(name: String, uuid: String = UUID().uuidString, isAssigned: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.uuid = uuid
    }
}//End of Extension
