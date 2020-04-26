

//
//  TweetCellBinder.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TweetCellBinder {
    static func bind(cell:TweetTableViewCell,item:Tweet) -> TweetTableViewCell{
        cell.tweetLabel.text = item.text
        
        cell.tweetLabel.textColor = TextColorStore.shared.value.getUIColor()
        
        cell.backgroundColor = .clear
        
        TextColorStore.shared.update().subscribe(){ event in
            let color = event.element!.getUIColor()
            cell.tweetLabel.textColor = color
        }.disposed(by: cell.disposeBag)
        
        return cell
    }
}
