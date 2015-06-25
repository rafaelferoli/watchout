//
//  CourseTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit
import CoreData

class CourseTableViewController: UITableViewController {
    
    var course: Course?
    var reminders = [Reminder]()
    var selectedReminder: Reminder?
    var professor: Professor?
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let name = course?.name {
            navigationItem.title = name
            professor = course?.professor
        }
        
        if let remindersArray = course?.reminders.allObjects as? [Reminder] {
            reminders = remindersArray
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return reminders.count
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 22))
        header.text = "Lembretes"
        header.textAlignment = .Center
        header.backgroundColor = UIColor.lightGrayColor()
        return header
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! UITableViewCell

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if let name = professor?.name {
                    cell.textLabel?.text = name
                }
            } else {
                if let email = professor?.email {
                    cell.textLabel?.text = email
                }
            }
            
        } else if indexPath.section == 1 {
            let reminder = reminders[indexPath.row]
            cell.textLabel?.text = reminder.title
            
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 { return }
        selectedReminder = reminders[indexPath.row]
        performSegueWithIdentifier("showReminder", sender: nil)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentNewReminder" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let vc = nav.visibleViewController as? NewReminderTableViewController {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let managedContext = appDelegate.managedObjectContext!
                    if let entity = NSEntityDescription.entityForName("Reminder", inManagedObjectContext: managedContext) {
                        let reminder = Reminder(entity: entity, insertIntoManagedObjectContext: managedContext)
                        if course != nil {
                            reminder.course = course!
                        }
                        
                        vc.reminder = reminder
                        vc.editingReminder = false
                    }
                    
                }
            }
        } else if segue.identifier == "showReminder" {
            if let vc = segue.destinationViewController as? ReminderTableViewController {
                vc.reminder = selectedReminder
            }
        }
        
        
    }
    

}
