//
//  Lecture.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import Foundation
import CoreData

class Lecture: NSManagedObject {

    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    @NSManaged var number: NSDecimalNumber
    @NSManaged var weekDay: WeekDay
    @NSManaged var course: Course

}
