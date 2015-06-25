//
//  NewCourseTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit
import CoreData

class NewCourseTableViewController: UITableViewController {
    
    var course: Course?
    var professor: Professor?

    @IBOutlet weak var courseNameTextField: UITextField!
    
    @IBAction func nameDidChanged(sender: UITextField) {
        course?.name = sender.text
    }
    

    @IBOutlet weak var professorNameTextField: UITextField!
    
    @IBAction func professorNameDidChange(sender: UITextField) {
        professor?.name = sender.text
    }
    
    
    @IBOutlet weak var emailProfessorTextField: UITextField!
    
    @IBAction func emailProfessorDidChange(sender: UITextField) {
        professor?.email = sender.text
    }
    
    
    @IBAction func save(sender: AnyObject) {
        if let context = course?.managedObjectContext {
            context.save(nil)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if let context = course?.managedObjectContext {
            context.deleteObject(course!)
            context.save(nil)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        if let entity = NSEntityDescription.entityForName("Professor", inManagedObjectContext: managedContext) {
            professor = Professor(entity: entity, insertIntoManagedObjectContext: managedContext)
            course?.professor = professor!
        }
        managedContext.save(nil)
    }
}
