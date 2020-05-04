//
//  PurchaseManager.swift
//  pitty
//
//  Created by Ryosuke Tamura on 2019/11/23.
//  Copyright © 2019 Ryosuke Tamura. All rights reserved.
//

import SwiftyStoreKit
import StoreKit.SKError
import RxSwift
import RxCocoa
import PKHUD

class PurchaseManager: NSObject {
    
    // 自動的に遅延初期化される(初回アクセスのタイミングでインスタンス生成)
    static let shared = PurchaseManager()
    // 外部からのインスタンス生成をコンパイルレベルで禁止
    private override init() {}
    
    private let userDefault = UserDefaults()
    
    public enum Purcheses : String{
        case adRemove = "tokyo.crouton.tweetclock.ad_remover"
    }
    
    func purchase(vc:PurchaseDelegate,purchese:Purcheses){
        HUD.show(.progress)
        SwiftyStoreKit.purchaseProduct(purchese.rawValue, quantity: 1, atomically: true) { result in
            HUD.hide()
            switch result {
            case .success:
                self.recordPurchase(purchase: purchese)
                vc.purchaseSuccsess(purchase: purchese)
            case .error(let error):
                if error.code == .paymentCancelled{
                    vc.popAlert(title: "お知らせ", messege: "キャンセルされました", time: 1.5)
                }else{
                    vc.popAlert(title: "エラー", messege: "なんらかのエラーにより購入できませんでした", time: 1.5)
                }
                vc.purchaseError(errorCode: error)
            }
            vc.purchaseComplation()
        }
    }
    
    func restore(vc:PurchaseDelegate, purchese:Purcheses, _ success: @escaping () -> Void = {}, _ faild: @escaping () -> Void = {}, _ nothing: @escaping () -> Void = {}){
        HUD.show(.progress)
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            HUD.hide()
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                vc.popAlert(title: "エラー", messege: "なんらかのエラーにより復元できませんでした", time: 1.5)
            }
            else if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoredPurchases)")
                self.recordPurchase(purchase: purchese)
                vc.restoreSuccsess(purchase: purchese)
            }
            else {
                print("Nothing to Restore")
                vc.popAlert(title: "エラー", messege: "リストアされませんでした", time: 1.5)
            }
            vc.purchaseComplation()
        }
    }
    
    func recordPurchase(purchase:Purcheses){
        userDefault.setValue(true, forKey: purchase.rawValue)
    }
    
    func checkPurchased(purchase:Purcheses) -> Bool{
        return userDefault.bool(forKey: purchase.rawValue)
    }
}

protocol PurchaseDelegate:UIViewController {
    func purchaseSuccsess(purchase: PurchaseManager.Purcheses)
    func restoreSuccsess(purchase: PurchaseManager.Purcheses)
    func purchaseError(errorCode: SKError)
    func purchaseComplation()
}
