//
//  Professor.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import Foundation
import CoreData

class Professor: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var email: String
    @NSManaged var courses: NSSet

}
