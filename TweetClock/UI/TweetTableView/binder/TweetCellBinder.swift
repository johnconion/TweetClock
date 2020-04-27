

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
import Kingfisher

class TweetCellBinder {
    static func bind(cell:TweetTableViewCell,item:Tweet) -> TweetTableViewCell{
        cell.tweetLabel.text = item.text
        
        cell.tweetLabel.textColor = TextColorStore.shared.value.getUIColor()
        cell.userIcon.kf.setImage(with: item.user.iconUrl)
        cell.userNameLabel.text = item.user.userName
        cell.rtAndFavLabel.text = "\(String(item.retweetCount))RT \(String(item.favoriteCount))Fav"
        cell.backgroundColor = .clear
        
        cell.img1.image = nil
        cell.img2.image = nil
        cell.img3.image = nil
        cell.img4.image = nil
        
        for (index, value) in item.images.enumerated() {
            switch index {
            case 0:
                cell.img1.kf.setImage(with: value.imageUrl)
            case 1:
                cell.img2.kf.setImage(with: value.imageUrl)
            case 2:
                cell.img3.kf.setImage(with: value.imageUrl)
            case 3:
                cell.img4.kf.setImage(with: value.imageUrl)
            default:
                print("error img")
            }
        }
        
        TextColorStore.shared.update().subscribe(){ event in
            let color = event.element!.getUIColor()
            cell.userNameLabel.textColor = color
            cell.rtAndFavLabel.textColor = color
            cell.tweetLabel.textColor = color
        }.disposed(by: cell.disposeBag)
        
        return cell
    }
}
