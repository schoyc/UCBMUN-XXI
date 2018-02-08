//
//  StripeViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 2/21/17.
//  Copyright © 2017 Steven Chen. All rights reserved.
//

import UIKit
// import Stripe

class StripeViewController: UIViewController {

////    @IBOutlet weak var buyButton: UIButton!
////    //var paymentField : STPPaymentCardTextField
////    
////    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        let paymentField = STPPaymentCardTextField(frame: CGRect(x: 10, y: 10, width:300, height: 44))
////        paymentField.delegate = self
////       // self.paymentField = paymentField
////        self.view.addSubview(paymentField)
////
////        // Do any additional setup after loading the view.
////    }
////
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
////    
////    
////    // MARK: STPPaymentCardTextFieldDelegate
////    
////    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
////        print("Card number: \(textField.cardParams.number) Exp Month: \(textField.cardParams.expMonth) Exp Year: \(textField.cardParams.expYear) CVC: \(textField.cardParams.cvc)")
////        self.buyButton.isEnabled = textField.isValid
////    }
////    
////    @IBAction func purchaseButtonClicked(_ sender: Any) {
////        for view in self.view.subviews {
////            if let paymentField = view as? STPPaymentCardTextField {
////                
////            }
////            else {
////                // obj is not a string array
////            }
////        }
////        
////        
////    }
//    
//    func postStripeToken(token: STPToken) {
    
//        let URL = "http://localhost/charges/mobile"
//        let params = ["stripeToken": token.tokenId,
//                      "amount": self.amountTextField.text.toInt()!,
//                      "currency": "usd",
//                      "description": self.emailTextField.text,
//                      "email" : "email"]
//        
//        let manager = AFHTTPRequestOperationManager()
//        manager.POST(URL, parameters: params, success: { (operation, responseObject) -> Void in
//            
//            if let response = responseObject as? [String: String] {
//                UIAlertView(title: response["status"],
//                            message: response["message"],
//                            delegate: nil,
//                            cancelButtonTitle: "OK").show()
//            }
//            
//        }) { (operation, error) -> Void in
//            self.handleError(error!)
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
