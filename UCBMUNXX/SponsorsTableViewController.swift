//
//  SponsorsTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/20/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class SponsorsTableViewController: ExpandableTableViewController  {
    
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sponsors"
        //NotificationCenter.default.addObserver(self, selector: #selector(self.presentProgramming), name:NSNotification.Name(rawValue: "TEST"), object: nil)
        
    }
    
    override func loadData() {
        groupArray = ["University of California, San Diego", "University of San Francisco", "Seattle University School of Law", "Berkeley Political Review"]
        boolArray = [Bool](repeating: false, count: groupArray.count)
        
        let seattle = [
            ProgramEvent(name: "Seattle University School of Law", description: "Located near thriving downtown Seattle, Seattle University School of Law is home to the nation’s No. 1 Legal Writing Program and a legal clinical program ranked in the top 15. We are the most diverse law school in the Pacific Northwest and maintain a strong commitment to the cause of social justice and preparing great lawyers who are powerful and capable advocates. Learn more about our nationally-acclaimed JD curriculum at law.seattleu.edu.", time: "", location: "Website: law.seattleu.edu"),
        ]
        
        let usf = [
            ProgramEvent(name: "University of San Francisco", description: "Our Master’s in International Studies is a three-semester program that provides students with in-depth, interdisciplinary knowledge of the issues and challenges that face the global community in conjunction with practical, real-world experiences. Our curriculum focuses on development and the environment, political and economic aspects of globalization, human rights, peace and conflict resolution, and international law and organizations. We are still accepting applications for Fall 2017!", time: "10:00pm - 1:00am", location: "Website: usfca.edu/mais")
            
        ]
        
        let ucsd = [
            ProgramEvent(name:"University of California, San Diego", description: "The UC San Diego School of Global Policy and Strategy (GPS) offers graduate degrees in international affairs and public policy with an emphasis on Asia and the Americas. Leveraging our West Coast location and UC San Diego's renowned programs in science and technology, GPS students develop new analytic tools with real-world applications to find solutions to the most pressing global issues. Come speak personally to a representative from our team on Friday from 12-6:30pm or Saturday from 9-3pm!", time: "", location: "Website: gps.ucsd.edu")
        ]
        
        let bpr = [
            ProgramEvent(name:"Berkeley Political Review (BPR)", description: "Berkeley Political Review is the prestigious, sole non-partisan political publication on the UC Berkeley campus. In its short time, BPR has transformed from a small magazine to a campus powerhouse, receiving endorsement from the Institute of Governmental Studies and the Journalism School at UC Berkeley. BPR was also the first and only political review from a public university to be invited into the Alliance of Collegiate Editors, a national organization of top tier sociopolitical publications such as Harvard, Princeton, Brown, Duke, Columbia, and many more. ", time: "", location: "Website: bpr.berkeley.edu")
        ]
        
        dataDic["Seattle University School of Law"] = seattle
        dataDic["University of San Francisco"] = usf
        dataDic["University of California, San Diego"] = ucsd
        dataDic["Berkeley Political Review"] = bpr
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sponsorCell", for: indexPath) as! SponsorCell
        
        let boolForSec = boolArray[indexPath.section] as Bool
        if (boolForSec) {
            var arr : [AnyObject] = dataDic[groupArray[indexPath.section]]!
            let item = arr[indexPath.row] as! ProgramEvent
            cell.eventTitle?.text = item.name!
            cell.eventDescription?.text = item.description!
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


    
    
}
