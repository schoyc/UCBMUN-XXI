//
//  MUNChatTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/25/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MUNChatTableViewController: PFQueryTableViewController {
    
    let composePostSegue = "MUNChatToComposePost"
    
    
    @IBOutlet weak var recentOrPopularControl: UISegmentedControl!
    
//    private var parentPostId: String?
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//    }
//    
//    deinit {
//        print("deinit MUNChatTableViewController")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.204, green:0.286, blue:0.369, alpha:1)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        //recentOrPopularControl.addTarget(self, action: "recentOrPopularChanged", forControlEvents: .ValueChanged)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadObjects()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = PFUser.current() {
            if user.username == nil {
                print("NOT LOGGED IN GOING TO LOGIN SCREEN NOW")
                performSegue(withIdentifier: "MUNChatToLogin", sender: nil)
            }
            print("LOGGED IN")
            if user.isAuthenticated {
               print("AUTHENTICATED")
            }
            
        } else {
            print("NOT LOGGED IN GOING TO LOGIN SCREEN")
            print("WHY YOU DO DIS")
            performSegue(withIdentifier: "MUNChatToLogin", sender: nil)
        }
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        switch recentOrPopularControl.selectedSegmentIndex {
            case 0:
                let query = MUNChatPost.query()
                return query!
            case 1:
                let query = MUNChatPost.queryPopularPosts()
                return query!
            default:
                let query = MUNChatPost.query()
                return query!
        }
        
    }
    
    
    func recentOrPopularChanged() {
        loadObjects()
        
    }
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        loadObjects()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath as IndexPath) as! MUNChatTableViewCell
        let post = object as! MUNChatPost
        
        cell.postImage.file = post.image!
        cell.postImage.load(inBackground: nil) { percent in
            print("\(percent)%")
        }
        //cell.postImage.contentMode = UIViewContentMode.scaleAspectFill
        
        let creationDate = post.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a, EEE"
        let dateString = dateFormatter.string(from: creationDate!)
        
        cell.postUser.text = post.user.username
        cell.postTime.text = dateString
        //cell.postScore.text = post.score.toString()
        
//        if let username = post.user.username {
//            cell.postUser.text = "Uploaded by: \(username), \(dateString)"
//        } else {
//            cell.createdByLabel.text = "Uploaded by anonymous: , \(dateString)"
//        }
        
        //cell.createdByLabel.text = "Uploaded by: \(wallPost.user.username), \(dateString)"
        
        cell.postText.text = post.text
        cell.postText.numberOfLines = 0
        cell.postText.sizeToFit()
        cell.postScore.text = String(post.score)
        if PFUser.current() != nil {
            if let hasUpVote = post.votes[PFUser.current()!.objectId!] {
                if hasUpVote {
                    cell.upVoteButton.setImage(UIImage(named: "upvote_dark.png"), for: UIControlState.normal)
                    cell.downVoteButton.setImage(UIImage(named: "downvote.png"), for: UIControlState.normal)
                } else {
                    cell.downVoteButton.setImage(UIImage(named: "downvote_dark.png"), for: UIControlState.normal)
                    cell.upVoteButton.setImage(UIImage(named: "upvote.png"), for: UIControlState.normal)
                }
            } else {
                cell.upVoteButton.setImage(UIImage(named: "upvote.png"), for: UIControlState.normal)
                cell.downVoteButton.setImage(UIImage(named: "downvote.png"), for: UIControlState.normal)
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
            case "MUNChatToPostReplies":
                let tapPoint = (sender! as AnyObject).convert(CGPoint.zero, to: self.tableView)
                let tapIndex = self.tableView.indexPathForRow(at: tapPoint)
                let post = object(at: tapIndex) as! MUNChatPost
                
                let repliesVC = segue.destination as! MUNChatRepliesTableViewController
                repliesVC.setParentPost(id: post.objectId!)
            case self.composePostSegue:
                let composePostVC = segue.destination as! ComposePostViewController
                composePostVC.setPostToReply("")
            case "MUNChatToFlagPost":
                let tapPoint = (sender! as AnyObject).convert(CGPoint.zero, to: self.tableView)
                
                let tapIndex = self.tableView.indexPathForRow(at: tapPoint)
                let post = object(at: tapIndex) as! MUNChatPost
                
                let flagVC = segue.destination as! FlagPostViewController
                flagVC.setFlagPost(post)
        default:
            print("No segue prep")
            
            
        }

    }
    
    
    // MARK: Buttons
    
    @IBAction func upVotePressed(sender: AnyObject) {
        let tapPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let tapIndex = self.tableView.indexPathForRow(at: tapPoint)
        let post = object(at: tapIndex) as! MUNChatPost
        let currentUserId = PFUser.current()!.objectId!
        
        
        //No votes pressed
        //Upvote already pressed
        //Downvote already pressed
        
        if let isUpVote = post.votes[currentUserId] {
            if !isUpVote {
                post.incrementKey("score", byAmount: 2)
                post.votes[currentUserId] = true
                post.saveInBackground()
                self.tableView.reloadRows(at: [tapIndex!], with: UITableViewRowAnimation.none)
            } else {
                post.incrementKey("score", byAmount: -1)
                post.votes.removeValue(forKey: currentUserId)
                post.saveInBackground()
                self.tableView.reloadRows(at: [tapIndex!], with: UITableViewRowAnimation.none)
            }
            
    
        } else {
            post.incrementKey("score")
            post.votes[currentUserId] = true
            post.saveInBackground()
            self.tableView.reloadRows(at: [tapIndex!], with: UITableViewRowAnimation.none)
        }
    }
    
    @IBAction func downVotePressed(sender: AnyObject) {
        let tapPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let tapIndex = self.tableView.indexPathForRow(at:
            
            
            tapPoint)
        let post = object(at: tapIndex) as! MUNChatPost
        let currentUserId = PFUser.current()!.objectId!
        
        //No votes pressed
        //Upvote already pressed
        //Downvote already pressed
        
        if let isUpVote = post.votes[currentUserId] {
            if isUpVote {
                post.incrementKey("score", byAmount: -2)
                post.votes[currentUserId] = false
                post.saveInBackground()
                self.tableView.reloadRows(at: [tapIndex!], with: UITableViewRowAnimation.none)
            } else {
                post.incrementKey("score", byAmount: 1)
                post.votes.removeValue(forKey: currentUserId)
                post.saveInBackground()
                self.tableView.reloadRows(at: [tapIndex!], with: UITableViewRowAnimation.none)
            }
            
            
        } else {
            post.incrementKey("score", byAmount: -1)
            post.votes[currentUserId] = false
            post.saveInBackground()
            self.tableView.reloadRows(at: [tapIndex!], with: UITableViewRowAnimation.none)
        }
    }
    
    @IBAction func flagPressed(sender: AnyObject) {
        performSegue(withIdentifier: "MUNChatToFlagPost", sender: sender)
    }
    
    
    @IBAction func repliesPressed(sender: AnyObject) {
        performSegue(withIdentifier: "MUNChatToPostReplies", sender: sender)
    }
    
    @IBAction func composePressed(sender: AnyObject) {
        performSegue(withIdentifier: self.composePostSegue, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.backgroundColor = UIColor(red:0.937, green:0.937, blue:0.937, alpha:1)
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 410.0))
        
        whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
        whiteRoundedView.layer.masksToBounds = false
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        print("HELLO")
        PFUser.logOut()
        print(PFUser.current()?.username)
       performSegue(withIdentifier: "MUNChatToLogin", sender: sender)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        print("HELLO")
        PFUser.logOut()
        //print(PFUser.current()?.username)
        performSegue(withIdentifier: "MUNChatToLogin", sender: sender)
    }

    // MARK: - Table view data source
    
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.layer.backgroundColor = UIColor(red:0.937, green:0.937, blue:0.937, alpha:1).CGColor
        return v
    } */

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}
