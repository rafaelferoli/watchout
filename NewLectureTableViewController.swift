//
//  NewLectureTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit

class NewLectureTableViewController: UITableViewController {
    
    var lecture: Lecture?
    var course: Course?

    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBAction func cancel(sender: AnyObject) {
        if lecture != nil {
            if let context = lecture!.managedObjectContext {
                context.deleteObject(lecture!)
                context.save(nil)
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func salvar(sender: AnyObject) {
        if lecture != nil {
            lecture?.startTime = startDatePicker.date
            lecture?.endTime = endDatePicker.date
            if course != nil {
                lecture?.course = course!
            }
        }
        
        if let context = lecture?.managedObjectContext {
            context.save(nil)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            performSegueWithIdentifier("showCourses", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCourses" {
            if let vc = segue.destinationViewController as? CoursesTableViewController {
                vc.lecture = lecture
            }
        }
    }
}
