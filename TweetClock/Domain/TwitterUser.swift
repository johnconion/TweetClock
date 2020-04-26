//
//  TwitterUser.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class TwitterUser {
    let iconUrl : URL!
    let userName : String!
    
    init(iconUrl:URL,userName:String) {
        self.iconUrl = iconUrl
        self.userName = userName
    }
}
