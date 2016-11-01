//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/31/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    //@IBOutlet weak var composeTextField: UITextField!
    
    @IBOutlet weak var composeTextView: UITextView!
    
    var user: User!
    
    override func viewDidAppear(_ animated: Bool) {
        //composeTextField.becomeFirstResponder()
        composeTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.04, green: 0.6, blue: 0.98, alpha: 0.9)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        usernameLabel.text = user.screenname as String?
        nameLabel.text = user.name as String?
        profileView.setImageWith(user.profileUrl as! URL)
        
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
    

}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


