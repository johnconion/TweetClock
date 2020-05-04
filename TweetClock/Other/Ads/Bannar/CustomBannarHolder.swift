//
//  CustomBannarView.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/05/04.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CustomBannarHolder {
    
    private var bannerView : GADBannerView!
    
    init(bannerView : GADBannerView) {
        self.bannerView = bannerView
    }
    
    func set(adID:BannarIdKind, rootViewController:UIViewController) {
        bannerView.adSize = kGADAdSizeBanner
        bannerView.adUnitID = adID.rawValue
        bannerView.rootViewController = rootViewController
        bannerView.load(GADRequest())
    }
    
    func getBannerView() -> GADBannerView { bannerView }
}
