//
//  HomeTableViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/13/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomePageTableViewController: PFQueryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.204, green:0.286, blue:0.369, alpha:1)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        let logo = UIImage(named: "logo_white.png")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .scaleAspectFit
        imageView.image = logo
        self.navigationItem.titleView = imageView
        
//        let testData = UIImageJPEGRepresentation(UIImage(named: "wsf.png")!, 0.9)
// 
//        let testFile = PFFile(name: "test", data: testData!)
//        let testPost = NewsPost(image: testFile!, text: "UCBMUN!!!", priority: 0)
//
//        testPost.saveInBackground()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
                NotificationCenter.default.addObserver(self, selector: #selector(self.programmingNotification), name:NSNotification.Name(rawValue: "ProgrammingNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.merchNotif), name:NSNotification.Name(rawValue: "MerchNotif"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.chatNotif(notifcation:)), name:NSNotification.Name(rawValue: "ChatNotif"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.homeNotif), name:NSNotification.Name(rawValue: "HomeNotif"), object: nil)
    }
    
    func programmingNotification(notifcation: NSNotification) {
        print("TESTING NOTIFICATION")
        self.performSegue(withIdentifier: "TestSegue", sender: self)
    }
    
    func merchNotif(notifcation: NSNotification) {
        self.performSegue(withIdentifier: "HomeToMerch", sender: self)
    }
    
    func chatNotif(notifcation: NSNotification) {
        self.performSegue(withIdentifier: "HomeToChatSegue", sender: self)
    }
    
    func homeNotif(notifcation: NSNotification) {
        print("Already Home")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        loadObjects()
    }
    
    override func queryForTable() -> PFQuery<PFObject> {
        let query = NewsPost.query()
        return query!
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, object: PFObject!) -> PFTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPostCell", for: indexPath) as! NewsPostTableViewCell
        let post = object as! NewsPost
        
        cell.newsImage.file = post.image!
        //cell.newsImage.loadInBackground()
        cell.newsImage.load(inBackground: nil) { percent in
            cell.progressLoading.progress = Float(percent)*0.01
        }
        
        let creationDate = post.createdAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        let dateString = dateFormatter.string(from: creationDate!)
        
        cell.newsHeadline.text = post.headline
        cell.newsText.text = post.text
        cell.newsDate.text = dateString
        return cell
    }
    
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.backgroundColor = UIColor(red:0.937, green:0.937, blue:0.937, alpha:1)
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 400.0))
        
        whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
        whiteRoundedView.layer.masksToBounds = false
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
    }
    
    
    @IBAction func goToMagoosh(_ sender: AnyObject) {
        
        UIApplication.shared.openURL(URL(string:"http://magoosh.com")!)
    }
    


}
