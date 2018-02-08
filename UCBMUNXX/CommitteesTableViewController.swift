//
//  CommitteesTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/4/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class CommitteesTableViewController: ExpandableTableViewController {

    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Committees"
    }
    
    override func loadData() {
        groupArray = ["Specialized Bodies","Crisis Committees", "Joint Crisis Committees"]
        boolArray = [Bool](repeating: false, count: groupArray.count)
        
        let sbs = [
            Committee(name: "DISEC:", subtitle :  "The First Committee of the United Nations General Assembly", image:"disec.png", room: "Pine (Th), Grand Ballroom (F/Sa)"),
            Committee(name: "UNESCO:",
                      subtitle: "Media Pluralism and Sexual Literacy in the 21st Century", image:"unesco.png", room: "4th Floor, Columbus I"),
            Committee(name: "NBA Owners Meeting 1989:",
                      subtitle: "Building a Global Game", image:"nba.png", room: "4th Floor, Columbus II"),
            Committee(name: "The FAO 2020:",
                      subtitle: "Balancing Aid, Energy, and Security", image:"fao.png", room: "4th Floor, Columbus III"),
            Committee(name: "Trial of the Juntas:",
                      subtitle: "Defining Justice after the Dirty War", image:"legal.png", room: "PDR (Th), Pine (F/Sa)")
        ]
        
        let crises = [
            Committee(name: "The Ad Hoc Committee of the Secretary-General", subtitle: "", image:"adhoc.png", room: "2nd Floor, Pyramid"),
            Committee(name: "Building Zion:",
                      subtitle: "Mormon Pioneers and the Founding of Utah", image:"zion.png", room: "1st Floor, Grant"),
            Committee(name: "Thailand 2014:",
                      subtitle: "The Bangkok Shutdown", image:"thailand.png", room: "2nd Floor, Front"),
            Committee(name: "The Porfiriato:",
                      subtitle: "Mexico's Anti-Revolution", image:"mexico.png", room: "2nd Floor, Montgomery"),
            Committee(name: "The United Nations Security Council",
                      subtitle: "of the Secretary-General", image:"unsc.png", room: "1st Floor, 750 Restaurant"),
            Committee(name: "The Teutonic Knights of 1226:", subtitle: "The Rise and Fall of Europe", image: "teutonic.png", room: "2nd Floor, Washington"),
            Committee(name: "The Mau Mau Uprising:",
                      subtitle: "The Beginning of the End of British Kenya", image:"maumau.png", room: "2nd Floor, Davis"),
            Committee(name: "Death of Lenin:",
                      subtitle: "Authoritarian Transition & the Communist Experiment", image: "lenin.png", room: "1st Floor, Valencia"),
            Committee(name: "May Days",
                      subtitle: "The Hong Kong Riots of 1967", image:"hongkong.png", room: "1st Floor, Embarcadero"),
            Committee(name: "Paper Tigers:",
                      subtitle: "The Asian Financial Crisis of 1997", image:"asiafin.png", room: "2nd Floor, Sansome"),

            
        ]
        
        let jcc = [
            Committee(name: "The Egyptian Revolution:",
                      subtitle: "The Egyptian Government", image:"government.png", room: "2nd Floor, Mason 1"),
            Committee(name: "The Egyptian Revolution:",
                      subtitle: "The Egyptian Rebels", image:"rebels.png", room: "2nd Floor, Mason 2")
            
        ]
        
        dataDic["Specialized Bodies"] = sbs
        dataDic["Crisis Committees"] = crises
        dataDic["Joint Crisis Committees"] = jcc
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "committeesCell", for: indexPath) as! CommitteesTableViewCell
        
        let boolForSec = boolArray[indexPath.section] as Bool
        if (boolForSec) {
            var arr : [AnyObject] = dataDic[groupArray[indexPath.section]]!
            let item = arr[indexPath.row] as! Committee
            cell.committeeName?.text = item.name!
            cell.committeeSubtitle?.text = item.subtitle!
            cell.committeeRoom?.text = item.room!
            cell.committeeImage?.image = UIImage(named: item.image!)
            
        }else {
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        //headerView.backgroundColor = UIColor.blueColor()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "fromCommitteesToMap", sender: nil)
    }


}
