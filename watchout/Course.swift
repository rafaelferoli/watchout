//
//  Course.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var information: String
    @NSManaged var lectures: NSSet
    @NSManaged var reminders: NSSet
    @NSManaged var professor: Professor

}
