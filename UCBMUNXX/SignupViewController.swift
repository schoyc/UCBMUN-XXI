//
//  SignupViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/24/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    
    let signupSuccessSegue = "SignupToMUNChat"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupPressed(_ sender: AnyObject) {
        let user = PFUser()
        
        user.email = emailTextField.text
        user.password = passwordTextField.text
        user.username = nameTextField.text
        
        user.signUpInBackground {
            succeeded, error -> Void in
            if (succeeded) {
                //The registration was successful, go to the wall
                self.performSegue(withIdentifier: self.signupSuccessSegue, sender: nil)
            } else {
                //Something bad has occurred
                let alertView = UIAlertController(title: "Signup Error", message: "Something went wrong, please try again.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
                
            }
        }
        
        user.saveInBackground()
        
    }
    
    @IBAction func backToLogin(_ sender: AnyObject) {
        performSegue(withIdentifier: "SignUpToLogin", sender: nil)
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
