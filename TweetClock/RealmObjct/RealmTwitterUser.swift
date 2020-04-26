//
//  RealmTwitterUser.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTwitterUser: Object {
    @objc dynamic var iconUrl = ""
    @objc dynamic var userName = ""
}
