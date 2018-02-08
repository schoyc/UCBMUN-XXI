//
//  MUNStoreTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 1/30/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class MUNStoreTableViewController: UITableViewController {
    
    let products = [MerchProduct(name: "UCBMUN XXI T-Shirt", price: 15, description: "Remember your time at UCBMUN XXI with a limited edition shirt commemorating our 21st conference!", image: "munshirt.jpg"),
        MerchProduct(name: "UCBMUN XXI Beer Mug", price: 15, description: "Drink to substantive debate and joyous cameraderie with the first ever UCBMUN beer mug!", image: "munbeer.jpg"),
        MerchProduct(name: "UCBMUN XXI Shot Glass", price: 7, description: "Take a shot at your rival in committee, but then take a shot with them afterwards!", image: "munshot.jpg"),
        MerchProduct(name: "UCBMUN XXI Folder", price: 5, description: "Hold all of your committee papers and directives together in style.", image: "folders.jpg"),
        MerchProduct(name: "UCBMUN XXI Candy Gram", price: 3, description: "Send something sweet to that good looking delegate from New Zealand or your partner in crime in the Porfiriato.", image: "logo_orange.png"),
//        MerchProduct(name: "UCBMUN  Donations", price: 1, description: "This year, our conference is supporting the East Bay Sanctuary Covenant. Donate to a local coummunity of asylum-seekers and refugees.", image: "charity.jpg"),
        
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.204, green:0.286, blue:0.369, alpha:1)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationItem.hidesBackButton = true
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadProducts() {
        
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPurchaseItem", sender: tableView)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "merchCell", for: indexPath) as! MUNStoreTableViewCell
        let product = self.products[indexPath.row]
        
        cell.itemName.text = product.name
        cell.itemDescription.text = product.description
        cell.itemPrice.text = "$\(String(product.price!)).00"
        cell.itemPicture.image = UIImage(named: product.image!)
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "toPurchaseItem":
            let sender = sender as! UITableView
            let indexPath = sender.indexPathForSelectedRow!
            let product = self.products[indexPath.row]
            
            let purchaseItemVC = segue.destination as! PurchaseItemViewController
            purchaseItemVC.setProduct(product)
            
        default:
            print("No segue prep")
        }
        
        
    }
    
    

}
