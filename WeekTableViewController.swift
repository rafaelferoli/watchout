//
//  WeekTableViewController.swift
//  watchout
//
//  Created by Rafael Fernandes de Oliveira Carvalho on 6/20/15.
//  Copyright (c) 2015 Rafael Fernandes de Oliveira Carvalho. All rights reserved.
//

import UIKit
import CoreData

class WeekTableViewController: UITableViewController {
    
    var selectedWeekDay: WeekDay?
    var week = [WeekDay]()
    
    var days = ["SEGUNDA", "TERÇA", "QUARTA", "QUINTA", "SEXTA", "SÁBADO", "DOMINGO"]

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "WeekDay")
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [WeekDay] {
            week = results
            if week.count == 0 {
                for day in days {
                    let entity = NSEntityDescription.entityForName("WeekDay", inManagedObjectContext: managedContext)
                    let weekDay = WeekDay(entity: entity!, insertIntoManagedObjectContext: managedContext)
                    weekDay.name = day
                    var error: NSError?
                    if !managedContext.save(&error) {
                        println("error: \(error)")
                    }
                    week.append(weekDay)
                }
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return week.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weekDayCell", forIndexPath: indexPath) as! UITableViewCell

        let day = week[indexPath.row]
        cell.textLabel?.text = day.name

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedWeekDay = week[indexPath.row]
        performSegueWithIdentifier("showWeekDay", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeekDay" {
            if let vc = segue.destinationViewController as? WeekDayTableViewController {
                vc.weekDay = selectedWeekDay
            }
        }
    }
}
