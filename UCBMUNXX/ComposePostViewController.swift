//
//  ComposePostViewController.swift
//  UCBMUNXX
//
//  Created by Steven Chen on 12/24/15.
//  Copyright © 2015 Steven Chen. All rights reserved.
//

import UIKit
import Fusuma

class ComposePostViewController: UIViewController, UITextViewDelegate, FusumaDelegate {
    
    
    //Attributes 
    
//    @IBOutlet weak var imagePreview: UIImageView!
//    @IBOutlet weak var captionTextField: UITextView!
//    
//    @IBOutlet weak var imageLoadingSpinner: UIActivityIndicatorView!

    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var captionTextField: UITextView!
    @IBOutlet weak var imageLoadingSpinner: UIActivityIndicatorView!
    
    fileprivate var postToReply : String?
    
    let light_gray = UIColor(red:0.78, green:0.78, blue:0.804, alpha:1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
        captionTextField.text = "Caption that pic. (max 200 characters)"
        captionTextField.textColor = light_gray
        imageLoadingSpinner.hidesWhenStopped = true
        
        captionTextField.layer.borderColor = light_gray.cgColor
        captionTextField.layer.borderWidth = 0.75
        captionTextField.layer.cornerRadius = 5.0

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ComposePostViewController.dismissKeyboard))
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
    
    func setPostToReply(_ postId: String) {
        self.postToReply = postId
    }
    
    @IBAction func backPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func uploadPhotoPressed(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func takePhotoPressed(_ sender: AnyObject) {
        
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//        present(imagePicker, animated: true, completion: nil)
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)
    }

    
    @IBAction func postPressed(_ sender: AnyObject) {
        captionTextField.resignFirstResponder()
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        if imagePreview.image == nil {
            let alertView = UIAlertController(title: "Missing photo", message: "Don't forget to add a photo!", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Close", style: .default, handler: {(alert: UIAlertAction!) in self.navigationItem.rightBarButtonItem?.isEnabled = true}))
            present(alertView, animated: true, completion: nil)
            
        } else if captionTextField.text == "Caption that pic. (max 200 characters)"{
            let alertView = UIAlertController(title: "Missing caption", message: "Don't forget to add a caption!", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Close", style: .default, handler: {(alert: UIAlertAction!) in self.navigationItem.rightBarButtonItem?.isEnabled = true}))
            present(alertView, animated: true, completion: nil)
        
        } else {
            imageLoadingSpinner.startAnimating()
            let imageData = UIImageJPEGRepresentation(imagePreview.image!, 0.9)
            let file = PFFile(name: "image", data: imageData!)
            file?.saveInBackground({ (succeeded, error) -> Void in
                if succeeded {
                    self.savePost(file!)
                } else if let error = error {
                    print(error)
                }
            }, progressBlock: { percent in
                print("Uploaded: \(percent)%")
            })

        }
    }
    
    
    func savePost(_ file: PFFile)
    {
        let post = MUNChatPost(parentPostId: postToReply!, image: file, user: PFUser.current()!, username: PFUser.current()!.object(forKey: "username") as? String, text: self.captionTextField.text, score: 0, flag: "None")
        
        post.saveInBackground{succeeded, error in
            if succeeded {
                self.navigationController?.popViewController(animated: true)
            } else {
                print(error)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == light_gray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Caption that pic. (max 200 characters)"
            textView.textColor = light_gray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera:
            print("Image captured from Camera")
        case .library:
            print("Image selected from Camera Roll")
        default:
            print("Image selected")
        }
        
        imagePreview.image = image
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("video completed and output to file: \(fileURL)")
        // self.fileUrlLabel.text = "file output to: \(fileURL.absoluteString)"
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
        switch source {
        case .camera:
            print("Called just after dismissed FusumaViewController using Camera")
        case .library:
            print("Called just after dismissed FusumaViewController using Camera Roll")
        default:
            print("Called just after dismissed FusumaViewController")
        }
    }
    
    func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
        
        let alert = UIAlertController(title: "Access Requested", message: "Saving image needs to access your photo album", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) -> Void in
            
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func fusumaClosed() {
        print("Called when the FusumaViewController disappeared")
    }
    
    func fusumaWillClose() {
        print("Called when the close button is pressed")
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

extension ComposePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        //Place the image in the imageview
        imagePreview.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
