//
//  Tweet.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import SwiftDate

class Tweet {
    var id : String!
    var date : Date!
    var relativeDate : String { date.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.japanese) }
    var text : String!
    var favoriteCount : Int!
    var retweetCount : Int!
    
    var user : TwitterUser
    
    var images : [TwitterImage]
    
    init(id:String,date:Date,text:String,favoriteCount:Int,retweetCount:Int,user:TwitterUser,images:[TwitterImage]) {
        self.id = id
        self.date = date
        self.text = text
        self.favoriteCount = favoriteCount
        self.retweetCount = retweetCount
        self.user = user
        self.images = images
    }
}
