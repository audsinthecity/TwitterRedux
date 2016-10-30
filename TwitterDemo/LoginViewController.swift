//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/26/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(_ sender: AnyObject) {
                
        TwitterClient.sharedInstance?.login(success: {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }, failure: { (error: Error) -> () in
                print("Error: \(error.localizedDescription)")
        })
        
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
