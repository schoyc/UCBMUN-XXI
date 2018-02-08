//
//  PaymentViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/17/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    var cost : Int?
    
    @IBOutlet weak var costLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.cost = nil
    }
    
    deinit {
        print("Payment Submission Screen")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let costString = String(self.cost!)
        costLabel.text = "$\(costString).00"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMUNStore(_ sender: AnyObject) {
        
        //performSegue(withIdentifier: "toMUNStore", sender: nil)
        performSegue(withIdentifier: "toStripe", sender: nil)
    }
    
    
    @IBAction func goToVenmo(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string:"https://www.venmo.com/ucbmun_conference")!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
