//
//  Reminder.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import Foundation
import CoreData

class Reminder: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var type: NSDecimalNumber
    @NSManaged var date: NSDate
    @NSManaged var information: String
    @NSManaged var course: Course

}
