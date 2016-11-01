//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/31/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var composeTextView: UITextView!
    @IBOutlet weak var charsLeftLabel: UILabel!
    
    var user: User!
    var charCount: Int = 140
    
    override func viewDidAppear(_ animated: Bool) {
        composeTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.04, green: 0.6, blue: 0.98, alpha: 0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        composeTextView.delegate = self
        
        usernameLabel.text = user.screenname as String?
        nameLabel.text = user.name as String?
        profileView.setImageWith(user.profileUrl as! URL)
        charsLeftLabel.text = String(charCount)
        
        /*
        let fixedWidth = composeTextField.frame.size.width
        composeTextField.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = composeTextField.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = composeTextField.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        composeTextField.frame = newFrame
         */


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTweet(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance?.createTweet(status: composeTextView.text, reply: nil, success: { (tweet) in
            print("Successfully posted new Tweet")
            //self.dismiss(animated: true, completion: nil)
            let alertController = UIAlertController(title: "Success!", message: "Tweet posted", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the Cancel button");
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("you have pressed OK button");
            }
            alertController.addAction(OKAction)
            
            // The alertController ruins my segue
            //self.present(alertController, animated: true, completion:nil)
            
            }, failure: {
                print("Error on new Tweet post")
        })
        
        performSegue(withIdentifier: "backHome", sender: nil)
        

    }
    
    func updateCharacterCount() {
        self.charsLeftLabel.text = "\((140) - self.composeTextView.text.characters.count)"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.updateCharacterCount()
        return composeTextView.text.characters.count +  (text.characters.count - range.length) <= 140
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
