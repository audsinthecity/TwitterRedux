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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oath") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("I got a token!")
            print(requestToken?.token)
            
            let urlString = "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken!.token!)"
            print("hey: " + urlString)
            let url = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=\(requestToken!.token!)")
            print(url)
            UIApplication.shared.open(url! as URL)

            }, failure: { (error: Error?) in
                print("error: \(error?.localizedDescription)")
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
