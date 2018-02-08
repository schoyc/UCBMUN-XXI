//
//  MUNChatRepliesTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/29/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MUNChatRepliesTableViewController: MUNChatTableViewController {
    
    private var parentPostId: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    deinit {
        print("deinit RepliesTableViewController")
    }
    
    func setParentPost(id: String?) {
        self.parentPostId = id!
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        let query = MUNChatPost.queryReplies(self.parentPostId)
        return query!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "RepliesToComposePost":
            let composePostVC = segue.destination as! ComposePostViewController
            composePostVC.setPostToReply(self.parentPostId!)
            
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
    
    @IBAction override func upVotePressed(sender: AnyObject) {
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
    
    @IBAction override func downVotePressed(sender: AnyObject) {
        let tapPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let tapIndex = self.tableView.indexPathForRow(at: tapPoint)
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



    
    @IBAction func replyPressed(sender: AnyObject) {
        performSegue(withIdentifier: "RepliesToComposePost", sender: sender)
    }
    
    
    
    @IBAction func flagClicked(sender: AnyObject) {
        performSegue(withIdentifier: "MUNChatToFlagPost", sender: sender)
    }
    


    

   
}
