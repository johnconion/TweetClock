//
//  TwitterAccount.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class TwitterAccount {
    var key : String?
    var secret : String?
    var userID : String?
    var screenName : String?
    
    func isLogined() -> Bool{ key.notNil() && secret.notNil() && userID.notNil() && screenName.notNil() }
    
    init() {}
    
    init(key:String,secret:String,userID:String,screenName:String) {
        self.key = key
        self.secret = secret
        self.userID = userID
        self.screenName = screenName
    }
}
