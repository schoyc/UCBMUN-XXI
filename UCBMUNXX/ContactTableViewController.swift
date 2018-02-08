//
//  ContactTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/20/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
//    let contacts = [
//        ["Varsha Venkatasubramanian", "Secretary General", "(510) 697-6046", "varsha.jpg"],
//        ["Raymond King", "Deputy Secretary General", "(510) 693-7701", "raymond.jpg"],
//        
//        ["Beckett Kelly", "Chief of Staff--Internal & Office of Delegate Services", "925-437-0063", "beckett.jpg" ]
//    
//    ]
//    
//    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Us"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    

}
