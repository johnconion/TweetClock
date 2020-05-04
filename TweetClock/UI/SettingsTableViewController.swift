//
//  SettingsTableViewController.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyStoreKit
import StoreKit.SKError

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var twitterAccountLabel: UILabel!
    @IBOutlet weak var loadTimelineIntervalStepper: UIStepper!{
        didSet{
            loadTimelineIntervalStepper.rx.value.asObservable().skip(1).subscribe(){ v in
                let value = v.element!
                print("\(Int(value))分")
                self.loadTimeIntervalLabel.text = "\(Int(value))分"
                UserDefaultManager.setValue(key: .LoadTimelineInterval, value: value)
            }.disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var loadTimeIntervalLabel: UILabel!
    
    private let twitter = SwifterWrapper.share
    private let twitterAccountStore = TwitterAccountStore.shared
    
    private let disposeBag = DisposeBag()
    
    private let authUserAccountUseCase = AuthUserAccountUseCase()
    private let loadTimeLineUseCase = LoadTimeLineUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twitterAccountStore.update().subscribe(){ _ in
            self.checkTwitterAcccount()
        }.disposed(by: disposeBag)
        
        setLoadTimelineInterval()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // Cell が選択された場合
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            authUserAccountUseCase.execute(viewController: self,success: {
                self.dismiss(animated: true, completion: nil)
            },error: {})
        case 1:
            present(Router.presentColorSettingView(type: .BACKGROUND), animated: true, completion: nil)
        case 2:
            present(Router.presentColorSettingView(type: .TEXT), animated: true, completion: nil)
        case 4:
            popDialog3Red(title: "確認", messege: "課金することで、アプリ内の広告を消去できます", okString: "購入する", defaultString: "リストア", cancelString: "キャンセル", okFunc: {
                PurchaseManager.shared.purchase(vc: self, purchese: .adRemove)
            }, defaultFunc: {
                PurchaseManager.shared.restore(vc: self, purchese: .adRemove)
            }, cancelFunc: {})
        default:
            print("Error")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

private extension SettingsTableViewController{
    func setLoadTimelineInterval(){
        let value = UserDefaultManager.getDouble(key: .LoadTimelineInterval)
        loadTimelineIntervalStepper.value = value
        loadTimeIntervalLabel.text = "\(Int(value))分"
    }
    
    func checkTwitterAcccount(){
        if twitterAccountStore.value.isLogined(){
            twitterAccountLabel.text = "Twitterアカウント（設定済み）"
        }
    }
}

extension SettingsTableViewController:PurchaseDelegate{
    func purchaseSuccsess(purchase: PurchaseManager.Purcheses) {
        dismiss(animated: true, completion: nil)
    }
    
    func restoreSuccsess(purchase: PurchaseManager.Purcheses) {
        popAlert_comp(title: "お知らせ", messege: "復元が完了しました", time: 1.5){
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func purchaseError(errorCode: SKError) {
        print(errorCode)
    }
    
    func purchaseComplation() {}
}
