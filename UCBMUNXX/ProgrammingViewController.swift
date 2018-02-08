//
//  ProgrammingViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/20/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class ProgrammingViewController: ExpandableTableViewController {

    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Program"
        //NotificationCenter.default.addObserver(self, selector: #selector(self.presentProgramming), name:NSNotification.Name(rawValue: "TEST"), object: nil)
    }
    
    override func loadData() {
        groupArray = ["Thursday - Bear Crawl & Hookah Night", "Friday - Bear Fest", "Saturday - Bear Rave"]
        boolArray = [Bool](repeating: false, count: groupArray.count)
        
        let thursday = [
            ProgramEvent(name: "Bear Crawl", description: "We invite delegates who are 21+ to join us for a neighborhood bar crawl on Thursday night led by UCBMUN staff members. Come experience one of San Francisco’s most historic neighborhoods - one of the bars on our bar crawl was a favorite of the Beat Generation. Each bar has a different theme and all are in close proximity to the hotel.", time: "10:40pm - 1:00am", location: "Meet at Hilton Lobby."),
            ProgramEvent(name: "Hookah Night", description: "Join members of the UCBMUN staff as they travel to one of San Francisco’s premier Hookah Bars. We will have a night of tea, finger food, and hookah while experiencing a taste of San Francisco’s nightlife. You must be at least 21 to attend this event.", time: "11:30pm - 1:00am", location: "Meet at Hilton Lobby.")
        ]
        
        let friday = [
            ProgramEvent(name: "Bear Fest", description: "Food trucks, karaoke, and photos galore! Go out streetside to grab some delicious food, snacks, and dessert before heading inside to sing your heart out and get your photo taken with your favorite delegates.", time: "10:00pm - 1:00am", location: "Front of Hilton & Grand Ballroom, 3rd Floor")
            
        ]
        
        let saturday = [
            ProgramEvent(name:"Bear Rave", description: "UCBMUN’s greatly anticipated annual Soiree will take place on Saturday night, when the Horizon Ultra Lounge becomes hotter than the Delegate’s Lounge at the UN. Come celebrate a fantastic conference and dance the night away with new and old friends, allies, and adversaries. Meet in the lobby to walk over with UCBMUN members, or we'll just see you there!", time: "10:00pm - 2:00am", location: "498 Broadway Street, San Francisco, CA")
        ]
        
        dataDic["Thursday - Bear Crawl & Hookah Night"] = thursday
        dataDic["Friday - Bear Fest"] = friday
        dataDic["Saturday - Bear Rave"] = saturday
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "programCell", for: indexPath) as! ProgramEventCell
        
        let boolForSec = boolArray[indexPath.section] as Bool
        if (boolForSec) {
            var arr : [AnyObject] = dataDic[groupArray[indexPath.section]]!
            let item = arr[indexPath.row] as! ProgramEvent
            cell.eventTitle?.text = item.name!
            cell.eventDescription?.text = item.description!
            cell.eventTime?.text = item.time!
            cell.eventLocation?.text = item.location!
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
    
    func presentProgramming(notifcation: NSNotification) {
        print("Recieved progammming notification, trying to present now")
        self.navigationController?.pushViewController(self, animated: true)
    }


}
