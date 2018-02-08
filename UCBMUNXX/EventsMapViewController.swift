//
//  EventsMapViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 3/2/17.
//  Copyright © 2017 Steven Chen. All rights reserved.
//

import UIKit
import WebKit

class EventsMapViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var mainView: UIView! = nil
    
    var webView : WKWebView?
    
    
    override func loadView() {
        self.title = "Events Map"
        webView = WKWebView()
        webView!.navigationDelegate = self
        view = webView!
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "https://drive.google.com/open?id=1SP1AAVfCmkrIup63c7PBLpJetDE&usp=sharing")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        let requestObj = URLRequest(url: url)
        webView!.load(requestObj)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
