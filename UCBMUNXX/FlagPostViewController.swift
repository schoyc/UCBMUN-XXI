//
//  FlagPostViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/29/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit

class FlagPostViewController: UIViewController {
    
    fileprivate var flaggedPost : MUNChatPost
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.flaggedPost = MUNChatPost()
        super.init(coder: aDecoder)
        
    }
    
    deinit {
        print("deinit FlagPostViewController")
    }
    
    func setFlagPost(_ flaggedPost : MUNChatPost) {
        self.flaggedPost = flaggedPost
    }
    
    @IBAction func inappropriateSelected(_ sender: AnyObject) {
        flaggedPost.flag = "Inappropriate Content"
        flaggedPost.saveInBackground()
        self.navigationController?.popViewController(animated: true)
        //self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func rudeHurtfulSelected(_ sender: AnyObject) {
        flaggedPost.flag = "Rude/Hurtful"
        flaggedPost.saveInBackground()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func spamSelected(_ sender: AnyObject) {
        flaggedPost.flag = "Spam"
        flaggedPost.saveInBackground()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func otherSelected(_ sender: AnyObject) {
        flaggedPost.flag = "Other"
        flaggedPost.saveInBackground()
        self.navigationController?.popViewController(animated: true)
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
