//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Audrey Chaing on 10/29/16.
//  Copyright © 2016 Audrey Chaing. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "xDbCXCHD0GaC1ZsFDa26yj2Ea", consumerSecret: "4V2jbGICckxg0YJrBQ6NHhjN9pH4EP1ZlUwdblhMNEipfTvuS4")

}
