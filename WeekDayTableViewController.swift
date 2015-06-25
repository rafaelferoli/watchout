//
//  WeekDayTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit
import CoreData

class WeekDayTableViewController: UITableViewController {
    
    var weekDay: WeekDay?
    var selectedLecture: Lecture?
    var lectures = [Lecture]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let name = weekDay?.name {
            navigationItem.title = name
        }
        
        if let lecturesSet = weekDay?.lectures {
            if let lecturesArray = lecturesSet.allObjects as? [Lecture] {
                lectures = lecturesArray
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectures.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lectureCell", forIndexPath: indexPath) as! UITableViewCell

        let lecture = lectures[indexPath.row]
        cell.textLabel?.text = lecture.course.name
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let date = lecture.startTime
        cell.detailTextLabel?.text = formatter.stringFromDate(date)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLecture = lectures[indexPath.row]
        performSegueWithIdentifier("showCourse", sender: nil)
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let lecture = lectures[indexPath.row]
            if let managedContext = lecture.managedObjectContext {
                lectures.removeAtIndex(indexPath.row)
                managedContext.deleteObject(lecture)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
        }    
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentNewLecture" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let vc = nav.visibleViewController as? NewLectureTableViewController {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let managedContext = appDelegate.managedObjectContext!
                    if let entity = NSEntityDescription.entityForName("Lecture", inManagedObjectContext: managedContext) {
                        let lecture = Lecture(entity: entity, insertIntoManagedObjectContext: managedContext)
                        if let day = weekDay {
                            lecture.weekDay = day
                        }
                        
                        vc.lecture = lecture
                    }
                }
            }
        } else if segue.identifier == "showCourse" {
            if let vc = segue.destinationViewController as? CourseTableViewController {
                vc.course = selectedLecture?.course
            }
        }
            

    }
    

}
