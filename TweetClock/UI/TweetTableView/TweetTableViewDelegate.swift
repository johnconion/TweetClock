//
//  TweetTableViewDelegate.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class TweetTableViewDelegate: NSObject,UITableViewDelegate {
    
    var parentVC : UIViewController!
    
    private let tweetItemsStore = TweetItemsStore.shared

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.openTweet(vc: parentVC, id: tweetItemsStore.get(index: indexPath.row).id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
