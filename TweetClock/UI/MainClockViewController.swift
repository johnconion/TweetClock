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
import Swifter

class MainClockViewController: UIViewController {
    
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tweetTableView: UITableView!{
        didSet{
            tweetTableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "tweet_cell")
            tweetTableViewDelegate.parentVC = self
            tweetTableView.delegate = tweetTableViewDelegate
            tweetTableView.dataSource = tweetTableViewDataSourc
        }
    }
    
    private var tweetTableViewDelegate = TweetTableViewDelegate()
    private let tweetTableViewDataSourc = TweetTableViewDataSource()
    
    private let syncSignalDispatcher = SyncSignalDispatcher.shared
    private let disposeBag = DisposeBag()
    private let clock = Clock()
    private let battery = Battery()
    
    private let backgroundColorStore = BackgroundColorStore.shared
    private let textColorStore = TextColorStore.shared
    private let tweetItemsStore = TweetItemsStore.shared
    private let loadTimeLineUseCase = LoadTimeLineUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
        syncSignalDispatcher
            .clockTimer
            .subscribe(onNext: { [weak self] _ in
                guard self != nil else { return }
                self!.reloadView()
            })
            .disposed(by: disposeBag)
        
        syncSignalDispatcher
            .tweetTimer
            .subscribe(onNext: { [weak self] _ in
                guard self != nil else { return }
                self!.loadTimeLineUseCase.execute()
            }).disposed(by: disposeBag)
        
        backgroundColorStore.update().subscribe(){ event in
            let value = event.element!
            self.view.backgroundColor = value.getUIColor()
        }.disposed(by: disposeBag)
        
        textColorStore.update().subscribe(){ event in
            let value = event.element!
            let color = event.element!.getUIColor()
            self.dateLabel.textColor = color
            self.timeLabel.textColor = color
            self.tweetTableView.separatorColor = UIColor(red: value.getRedValue(), green: value.getGreenValue(), blue: value.getBlueValue(), alpha: 0.5)
        }.disposed(by: disposeBag)
        
        tweetItemsStore.updates().subscribe(){ event in
            self.tweetTableView.reloadData()
            self.tweetTableView.isHidden = false
        }.disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        // 初回起動時は非表示にする
        if tweetItemsStore.size() == 0 { tweetTableView.isHidden = true }
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
    
    @IBAction func tapSettingButton(_ sender: Any) {
        self.present(Router.presentSettingsView(), animated: true, completion: nil)
    }
    
    @IBAction func tapScroollButton(_ sender: Any) {
        tweetTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

private extension MainClockViewController{
    
    private func setLayout(){
        // ボタンに画像を設定
        settingsButton.setButtonColor(image: UIImage(named: "settings.png")!, color: .label)
        tweetTableView.separatorInset = .zero
        tweetTableView.layoutMargins = .zero
    }
    
    private func reloadView(){
        dateLabel.text = clock.getDateSting()
        timeLabel.text = clock.getTimeString()
        batteryLabel.text = battery.getBatteryPercentage()
    }
}

