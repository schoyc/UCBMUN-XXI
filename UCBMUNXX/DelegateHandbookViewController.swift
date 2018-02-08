//
//  DelegateHandbookViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/17/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit
import WebKit

class DelegateHandbookViewController: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet var mainView: UIView! = nil
    
    var webView : WKWebView?
    
    
    override func loadView() {
        self.title = "Delegate Handbook"
        webView = WKWebView()
        webView!.navigationDelegate = self
        view = webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL (string: "https://ucbmun.herokuapp.com/UCBMUN_delegate_handbook.pdf")!
        let requestObj = URLRequest(url: url)
        webView!.load(requestObj)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
