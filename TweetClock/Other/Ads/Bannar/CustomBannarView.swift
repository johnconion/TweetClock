//
//  CustomBannarView.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/05/04.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CustomBannarView: GADBannerView{
    func set(adID:BannarIdKind, rootViewController:UIViewController) {
        self.adSize = kGADAdSizeBanner
        self.adUnitID = adID.rawValue
        self.rootViewController = rootViewController
        self.load(GADRequest())
    }
    
    func load(){
        self.load(GADRequest())
    }
}
