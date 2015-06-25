//
//  CoursesTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit
import CoreData

class CoursesTableViewController: UITableViewController {
    
    var courses = [Course]()
    var lecture: Lecture?
    var selectedCourse: Course? {
        didSet {
            if selectedCourse != nil {
                lecture?.course = selectedCourse!
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "Course")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        if let results = fetchedResults as? [Course] {
            courses = results
            
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! UITableViewCell

        let course = courses[indexPath.row]
        cell.textLabel?.text = course.name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCourse = courses[indexPath.row]
    }
    
    // MARK: - Navigation

    @IBAction func presentNewCourse(sender: AnyObject) {
        performSegueWithIdentifier("presentNewCourse", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentNewCourse" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let vc = nav.visibleViewController as? NewCourseTableViewController {
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let managedContext = appDelegate.managedObjectContext!
                    if let entity = NSEntityDescription.entityForName("Course", inManagedObjectContext: managedContext) {
                        let course = Course(entity: entity, insertIntoManagedObjectContext: managedContext)
                        vc.course = course
                    }
                    
                }
            }
        }
    }
    

}
