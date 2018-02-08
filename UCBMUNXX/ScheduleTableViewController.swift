//
//  ScheduleTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 1/28/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

let cellID = "scheduleCell"
class ScheduleTableViewController: ExpandableTableViewController {
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schedule"
    }

    override func loadData() {
        groupArray = ["Thursday","Friday", "Saturday", "Sunday"]
        boolArray = [Bool](repeating: false, count: groupArray.count)
        
        let thursday = [
            ScheduleItem(name: "Registration", time: "3:30pm - 6:30pm"),
            ScheduleItem(name: "Model UN 101", time: "4:30pm - 6:00pm"),
            ScheduleItem(name: "Opening Ceremony", time: "7:00pm - 7:45pm"),
            ScheduleItem(name: "Committee Session I", time: "8:15pm - 10:15pm"),
            ScheduleItem(name: "Head Delegate Feedback", time: "10:15pm - 10:45pm"),
            ScheduleItem(name: "Bear Crawl", time: "10:40pm - 1:00am"),
            ScheduleItem(name: "Hookah Night", time: "11:30pm - 1:00am")
            
        ]
        
        let friday = [
            ScheduleItem(name: "Committee Session II", time:  "1:00pm - 5:00pm"),
            ScheduleItem(name: "Advisor Feedback Forum", time:  "3:00pm - 3:30pm"),
            ScheduleItem(name: "Dinner", time:  "5:00pm - 6:15pm"),
            ScheduleItem(name: "Committee Session III", time:  "6:15pm - 9:15pm"),
            ScheduleItem(name: "Head Delegate Feedback", time:  "9:30pm - 10:00pm"),
            ScheduleItem(name: "Bear Fest", time:  "10:00pm - 1:00am"),
    
        ]
    
        let saturday = [
            ScheduleItem(name: "Committee Session IV", time:  "10:00am - 1:00pm"),
            ScheduleItem(name: "Advisor Feedback Forum", time:  "11:30am - 12:00pm"),
            ScheduleItem(name: "Head Delegate Feedback", time:  "1:15pm - 1:45pm"),
            ScheduleItem(name: "Lunch", time:  "1:00pm - 3:00pm"),
            ScheduleItem(name: "Committee Session V", time:  "3:00pm - 7:00pm"),
            ScheduleItem(name: "Bear Rave", time:  "10:00pm - 2:00am"),
        ]
        
        let sunday = [ScheduleItem(name: "Closing Ceremony", time:  "10:00am - 12:00pm")]
        
        dataDic["Thursday"] = thursday
        dataDic["Friday"] = friday
        dataDic["Saturday"] = saturday
        dataDic["Sunday"] = sunday
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        
        let boolForSec = boolArray[indexPath.section] as Bool
        if (boolForSec) {
            var arr : [AnyObject] = dataDic[groupArray[indexPath.section]]!
            let item = arr[indexPath.row] as! ScheduleItem
            cell.itemName?.text = item.name!
            cell.itemTime?.text = item.time!
        }else {
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerView.backgroundColor = UIColor(red: 0.588, green:0.757, blue:0.839, alpha:1)
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = groupArray[section] as String
        headerString.textColor = UIColor.white
        headerString.font = UIFont(name:"HelveticaNeue-Medium", size: 16.0)
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }

}