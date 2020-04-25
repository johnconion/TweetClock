//
//  ViewController.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import SwiftDate
import RxCocoa
import RxSwift

class MainClockViewController: UIViewController {
    
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private let syncSignalDispatcher = SyncSignalDispatcher.shared
    private let disposeBag = DisposeBag()
    private let clock = Clock()
    private let battery = Battery()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncSignalDispatcher
        .clockTimer
        .subscribe(onNext: { [weak self] _ in
            guard self != nil else { return }
            self!.reloadView()
        })
        .disposed(by: disposeBag)
    }
    
    // ステータスバーを非表示にするためオーバーライドする
    override var prefersStatusBarHidden: Bool {
      return true
    }

    /*
     ドラッグを感知した際に呼ばれるメソッド.
     (ドラッグ中何度も呼ばれる)
     */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得.
        let aTouch: UITouch = touches.first!

        // 移動した先の座標を取得.
        let location = aTouch.location(in: self.view)

        // 移動する前の座標を取得.
        let prevLocation = aTouch.previousLocation(in: self.view)

        // ドラッグで移動したy距離をとる.
        let deltaY: CGFloat = (location.y - prevLocation.y) * -1

        // ドラックで画面の明るさを制御する
        UIScreen.main.brightness += deltaY / (self.view.frame.height / 3)
    }
}

private extension MainClockViewController{
    
    private func setLayout(){
        // ステータスバーを非表示にする
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func reloadView(){
        dateLabel.text = clock.getDateSting()
        timeLabel.text = clock.getTimeString()
        batteryLabel.text = battery.getBatteryPercentage()
    }
}

