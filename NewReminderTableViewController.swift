//
//  NewReminderTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit
import CoreData

class NewReminderTableViewController: UITableViewController, UITextFieldDelegate {
    
    var reminder: Reminder?
    
    var editingReminder = false

    @IBOutlet weak var titleTextField: UITextField!

    @IBAction func titleDidChanged(sender: UITextField) {
        reminder?.title = sender.text
        navigationItem.title = sender.text
    }
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    @IBAction func save(sender: AnyObject) {
        reminder?.date = dateDatePicker.date
        if let context = reminder?.managedObjectContext {
            context.save(nil)
        }
       
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if let context = reminder?.managedObjectContext {
            context.deleteObject(reminder!)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editingReminder {
            if let title = reminder?.title {
                titleTextField.text = title
                
            }
            
            if let date = reminder?.date {
                dateDatePicker.date = date
            }
        }
    }
}


