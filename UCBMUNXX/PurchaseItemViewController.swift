//
//  PurchaseItemViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 1/30/16.
//  Copyright © 2016 Steven Chen. All rights reserved.
//

import UIKit

class PurchaseItemViewController: UIViewController, UITextViewDelegate {
    
    fileprivate var product : MerchProduct?
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var quantityStepper: UIStepper!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var purchaseRecipient: UITextField!
    
    @IBOutlet weak var purchaseComment: UITextView!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        print("Replies Table View rendering")
        super.init(coder: aDecoder)
        self.product = nil
    }
    
    deinit {
        print("deinit RepliesTableViewController")
    }
    
    let light_gray = UIColor(red:0.78, green:0.78, blue:0.804, alpha:1)

    override func viewDidLoad() {
        super.viewDidLoad()

        quantityStepper.wraps = true
        quantityStepper.maximumValue = 10
        quantityStepper.value = 1
        
        productName.text = product?.name!
        productImage.image = UIImage(named: (product?.image!)!)
        
        productPrice.text = "$\(String(product!.price! * Int(quantityStepper.value))).00"
        
        purchaseComment.text = "Write your candygram message or any comments (e.g. shirt size) here."
        purchaseComment.textColor = light_gray
        purchaseComment.delegate = self
        purchaseComment.layer.borderColor = light_gray.cgColor
        purchaseComment.layer.borderWidth = 0.5
        purchaseComment.layer.cornerRadius = 5.0
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PurchaseItemViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveAndSubmitOrder(_ order : MerchOrder) {
        order.saveInBackground(block: {succeeded, error in
            if succeeded {
                self.performSegue(withIdentifier: "toVenmoScreen", sender: nil)
            } else {
                let alertView = UIAlertController(title: "Submission failure.", message: "Please try again.", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
            
        })
    }
    
    func setProduct(_ product : MerchProduct) {
        self.product = product
    }
    
    @IBAction func submitOrder(_ sender: AnyObject) {
        let current_user = PFUser.current()
        if product?.name! == "Candy Gram" {
            if purchaseRecipient.text! != "" {
                let order = MerchOrder(item: product!.name!, recipient: purchaseRecipient.text!, delivered: false, quantity: quantityStepper.value, comment: purchaseComment.text!, cost: product!.price! * Int(quantityStepper.value), sender: current_user?.username, email: current_user?.email)
                saveAndSubmitOrder(order)
                
            } else {
                let alertView = UIAlertController(title: "Missing Recipient", message: "We need someone to send the candy gram to!", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                present(alertView, animated: true, completion: nil)
                
            }
        } else {
            let order = MerchOrder(item: product!.name!, recipient: purchaseRecipient.text!, delivered: false, quantity: quantityStepper.value, comment: purchaseComment.text!, cost: product!.price! * Int(quantityStepper.value), sender: current_user?.username, email: current_user?.email)
            saveAndSubmitOrder(order)
        }
        
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        quantityLabel.text = (Int) (sender.value).description
        productPrice.text = "$\(String(product!.price! * Int(quantityStepper.value))).00"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == light_gray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your candygram message or any comments (e.g. shirt size) here."
            textView.textColor = light_gray
        }
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let paymentVC = segue.destination as! PaymentViewController
        paymentVC.cost = product!.price! * Int(quantityStepper.value)
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    
    

}
