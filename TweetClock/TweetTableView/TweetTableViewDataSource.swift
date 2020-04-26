//
//  TweetTableViewDataSource.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class TweetTableViewDataSource: NSObject,UITableViewDataSource {
    
    private let tweetItemsStore = TweetItemsStore.shared
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetItemsStore.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"tweet_cell", for: indexPath) as! TweetTableViewCell
        return TweetCellBinder.bind(cell: cell, item: tweetItemsStore.get(index: indexPath.row))
    }
}
