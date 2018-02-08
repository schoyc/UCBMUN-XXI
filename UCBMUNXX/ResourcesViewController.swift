//
//  SecondViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/24/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit

class ResourcesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let identifier = "resourceCell"
    
    let resources = [
        ["Schedule", "schedule.png", "fromResourcesToSchedule"],
        ["Committees", "committees.png", "fromResourcesToCommittees"],
        ["Program Events", "programming.png", "fromResourcesToProgramming"],
        ["Hotel Map", "hotel.png", "fromResourcesToHotelMap"],
        ["Sponsors", "sponsors.png", "fromResourcesToSponsorsLogos"],
        ["Events Map", "flag.png", "fromResourcesToEventsMap"],
        ["Contact Us", "contact.png", "fromResourcesToContacts"],
        ["Delegate Handbook", "handbook.png", "fromResourcesToHandbook"],
        ["Rules & Procedures", "rules.png", "fromResourcesToRules"],
//        ["Log Out", "logout.png", "fromResourcesToLogout"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.204, green:0.286, blue:0.369, alpha:1)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resources.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ResourceCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let resource = self.resources[indexPath.item]

        cell.resourceLabel.text = resource[0]
        cell.resourceIcon.image = UIImage(named: resource[1])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightGray
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let resource = self.resources[indexPath.item]
        performSegue(withIdentifier: resource[2], sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromResourcesToLogout" {
            PFUser.logOut()
        }
        
    }

  

}

