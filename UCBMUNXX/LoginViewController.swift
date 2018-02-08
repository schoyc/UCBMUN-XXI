//
//  LoginViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/24/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    let loginSuccessSegue = "LoginToMUNChat"
    
    override func viewDidLoad() {
        print("ERROR HERE???")
        super.viewDidLoad()
       //self.tabBarController?.tabBar.isHidden = true
       // self.navigationController?.navigationBar.isHidden = true
        passwordTextField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let user = PFUser.current() {
            if user.isAuthenticated {
                performSegue(withIdentifier: self.loginSuccessSegue, sender: nil)
            }
            
        } else {
            print("The user is not authenticated.")
        }
    }
    
    //MARK: - Actions
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: nameTextField.text!, password: passwordTextField.text!) { user, error in
            if user != nil {
                self.performSegue(withIdentifier: self.loginSuccessSegue, sender: nil)
                // self.dismiss(animated: true, completion: nil)
            } else {
                let alertView = UIAlertController(title: "Unable to Login", message: "Please try again.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func signupPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "LoginToSignup", sender: nil)
    }
    
    @IBAction func signupNavPressed(_ sender: Any) {
         performSegue(withIdentifier: "LoginToSignup", sender: nil)
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
