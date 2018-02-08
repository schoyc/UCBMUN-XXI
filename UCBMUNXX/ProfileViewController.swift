//
//  ProfileViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 1/2/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        universityLabel.text = PFUser.current()!.object(forKey: "university") as? String
        nameLabel.text = PFUser.current()!.object(forKey: "name") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutPressed(_ sender: AnyObject) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "ProfileToLogin", sender: nil)
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
