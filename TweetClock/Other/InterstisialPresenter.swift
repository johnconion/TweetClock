//
//  InterstisialPresenter.swift
//  ImageSplit
//
//  Created by Ryosuke Tamura on 2019/10/26.
//  Copyright © 2019 田村亮介. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InterstisialPresenter {
    
    // 自動的に遅延初期化される(初回アクセスのタイミングでインスタンス生成)
    static let shared = InterstisialPresenter()
    
    private var interstitial:GADInterstitial!
    
    var isReady:Bool {
        get{
            return interstitial.isReady
        }
    }
    
    func configure(){
        reloadAd()
    }
    
    // 外部からのインスタンス生成をコンパイルレベルで禁止
    private init() {
        //広告ID
        //test GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        reloadAd()
    }
    
    func presentInterstitial(rootViewController:UIViewController){
        if interstitial.isReady {
            interstitial.present(fromRootViewController: rootViewController)
            reloadAd()
        } else {
            print("Ad wasn't ready")
        }
    }
    
    private func reloadAd(){
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-7614390186769636/9690856568")
        interstitial.load(GADRequest())
    }
}
