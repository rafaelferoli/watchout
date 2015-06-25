//
//  ReminderTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit

class ReminderTableViewController: UITableViewController {
    
    var reminder: Reminder?

    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let title = reminder?.title {
            titleLabel.text = title
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .MediumStyle
        if let date = reminder?.date {
            dateLabel.text = formatter.stringFromDate(date)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentEditingReminder" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let vc = nav.visibleViewController as? NewReminderTableViewController {
                    vc.reminder = reminder
                    vc.editingReminder = true
                }
            }
        }
    
    }
}


