//
//  SplashViewController.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/26.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserDefaultManager.getBool(key: .FirstRun){
            FirstRun.execute()
        }
        
        // ステータスバーを非表示にする
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        present(Router.presentMainView(), animated: false, completion: nil)
    }
    
    // ステータスバーを非表示にするためオーバーライドする
    override var prefersStatusBarHidden: Bool {
      return true
    }
}
