//
//  WeekDay.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import Foundation
import CoreData

class WeekDay: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var lectures: NSSet

}
