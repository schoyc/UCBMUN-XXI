//
//  ExpandableTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 1/30/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//
//

import UIKit

class ExpandableTableViewController: UITableViewController {
    
    var groupArray = [String]()
    var boolArray : [Bool]!
    var dataDic = [String : [AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    func loadData() {
        groupArray = ["A","B"]
        boolArray = [Bool](repeating: false, count: groupArray.count)
        
        let groupA = ["BANGLADESH","INDIA","PAKISTHAN","SOUTH AFRICA"]
        let groupB = ["AUSTRALIA","ENGLAND","SRILANKA","WEST INDIES"]
        
        dataDic["A"] = groupA as [AnyObject]?
        dataDic["B"] = groupB as [AnyObject]?
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return groupArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let boolForSec = boolArray[section] as Bool
        if (boolForSec) {
            let arr = dataDic[groupArray[section]]
            return arr!.count
        }else {
            return 0
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCell", for: indexPath)
        
        let boolForSec = boolArray[indexPath.section] as Bool
        if (boolForSec) {
            var arr : [AnyObject] = dataDic[groupArray[indexPath.section]]!
            cell.textLabel?.text = arr[indexPath.row] as? String
        }else {
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        headerView.backgroundColor = UIColor.blue
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = groupArray[section] as String
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:#selector(ExpandableTableViewController.sectionHeaderTapped(_:)))
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(_ tapped: UITapGestureRecognizer){
        
        let section = tapped.view?.tag
        boolArray[section!] = !boolArray[section!]

        
        tableView.reloadSections(IndexSet(integer: section!), with: UITableViewRowAnimation.fade)
    }
}
