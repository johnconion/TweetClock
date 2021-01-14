//
//  Extentions.swift
//  meen
//
//  Created by Ryosuke Tamura on 2019/06/23.
//  Copyright © 2019 Ryosuke Tamura. All rights reserved.
//

import UIKit
import SafariServices

class IndicatorController{

    private func dissmissIndicator(VC:UIViewController){
        stopIndicator(vc: VC)
    }
    
    private func startIndicator(vc:UIViewController) {
        
        //開いた時のローディング
        let overView:UIView = UIView()
        let indicator = UIActivityIndicatorView()
        
        //開いた時のローディング画面
        overView.frame = CGRect(x: 0, y: 0, width: vc.view.frame.width, height: vc.view.frame.height)
        overView.center = CGPoint(x: vc.view.frame.width/2, y: vc.view.frame.height/2)
        overView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = vc.view.center
        
        vc.view.addSubview(overView)
        vc.view.addSubview(indicator)
        
        indicator.center = vc.view.center
        
        // 他のViewと被らない値を代入
        indicator.tag = 999
        overView.tag = 999
        
        vc.view.addSubview(overView)
        vc.view.addSubview(indicator)
        vc.view.bringSubviewToFront(overView)
        vc.view.bringSubviewToFront(indicator)
        
        indicator.startAnimating()
    }
    
    private func stopIndicator(vc:UIViewController) {
        vc.view.subviews.forEach {
            if $0.tag == 999 {
                $0.removeFromSuperview()
            }
        }
    }
}

extension UIViewController {
    
    func openWebViewFromUrl(url:URL?){
        if let notNilUrl = url{
            let safari = SFSafariViewController(url: notNilUrl)
            present(safari, animated: true, completion: nil)
        }
    }
    
    func popActionSheet(title:String,message:String,selects:[(text:String,Func:()->Void)],cancelFunc:@escaping()->Void){
        // styleをActionSheetに設定
        let alertSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        for select in selects{
            // 自分の選択肢を生成
            let action1 = UIAlertAction(title: select.text, style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) in
                select.Func()
            })
            alertSheet.addAction(action1)
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            cancelFunc()
        })
        
        alertSheet.addAction(action3)
        
        self.present(alertSheet, animated: true, completion: nil)
    }
    
    func popRedActionSheet(title:String,message:String,selects:[(text:String,Func:()->Void)],cancelFunc:@escaping()->Void){
        // styleをActionSheetに設定
        let alertSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        for select in selects{
            // 自分の選択肢を生成
            let action1 = UIAlertAction(title: select.text, style: UIAlertAction.Style.destructive, handler: {
                (action: UIAlertAction!) in
                select.Func()
            })
            alertSheet.addAction(action1)
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            cancelFunc()
        })
        
        alertSheet.addAction(action3)
        
        self.present(alertSheet, animated: true, completion: nil)
    }
    
    func popDialog1(title:String,messege:String,okString:String,okFunc:@escaping ()->Void){
        
        let alert: UIAlertController = UIAlertController(title: title, message: messege, preferredStyle:  UIAlertController.Style.alert)
        
        
        let defaultAction: UIAlertAction = UIAlertAction(title: okString, style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            okFunc()
        })
        // ③ UIAlertControllerにActionを追加
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func popDialog2(title:String,messege:String,okString:String,cancelString:String,okFunc:@escaping ()->Void,cancelFunc:@escaping()->Void){
        
        let alert: UIAlertController = UIAlertController(title: title, message: messege, preferredStyle:  UIAlertController.Style.alert)
        
        
        let defaultAction: UIAlertAction = UIAlertAction(title: okString, style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            okFunc()
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelString, style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            cancelFunc()
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func popDialog3Red(title:String,messege:String,okString:String,defaultString:String,cancelString:String,okFunc:@escaping ()->Void,defaultFunc:@escaping ()->Void,cancelFunc:@escaping()->Void){
        
        let alert: UIAlertController = UIAlertController(title: title, message: messege, preferredStyle:  UIAlertController.Style.alert)
        
        
        let okAction: UIAlertAction = UIAlertAction(title: okString, style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            okFunc()
        })
        
        let defaultAction: UIAlertAction = UIAlertAction(title: defaultString, style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            defaultFunc()
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelString, style: UIAlertAction.Style.destructive, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            cancelFunc()
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(okAction)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func popDialog3(title:String,messege:String,okString:String,defaultString:String,cancelString:String,okFunc:@escaping ()->Void,defaultFunc:@escaping ()->Void,cancelFunc:@escaping()->Void){
        
        let alert: UIAlertController = UIAlertController(title: title, message: messege, preferredStyle:  UIAlertController.Style.alert)
        
        
        let okAction: UIAlertAction = UIAlertAction(title: okString, style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            okFunc()
        })
        
        let defaultAction: UIAlertAction = UIAlertAction(title: defaultString, style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            defaultFunc()
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelString, style: UIAlertAction.Style.destructive, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            cancelFunc()
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(okAction)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func popAlert(title:String,messege:String,time:Double){
        // アラートを作成
        let alert = UIAlertController(
            title: title,
            message: messege,
            preferredStyle: .alert)
        
        // アラート表示
        self.present(alert, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
                alert.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    func popAlert_comp(title:String,messege:String,time:Double,comp:@escaping ()->Void){
        // アラートを作成
        let alert = UIAlertController(
            title: title,
            message: messege,
            preferredStyle: .alert)
        
        // アラート表示
        self.present(alert, animated: true, completion: {
            // アラートを閉じる
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: {
                alert.dismiss(animated: true, completion: nil)
                comp()
            })
        })
        
    }
    
}

extension UIView{
    
    func setVisibleOrFidden(_ v:Bool){
        self.isHidden = !v
    }
    
    func setMask(size: CGRect,radius:CGFloat){

        // Create a mutable path and add a rectangle that will be h
        let mutablePath = CGMutablePath()
        mutablePath.addRect(self.bounds)
        mutablePath.addRoundedRect(in:size, cornerWidth: radius, cornerHeight: radius)

        // Create a shape layer and cut out the intersection
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = CAShapeLayerFillRule.evenOdd

        // Add the mask to the view
        self.layer.mask = mask
    }
    
    func setShadow(){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5) // 影の方向(ここでは右下)
        self.layer.shadowOpacity = 0.3 // 影の濃さ
        self.layer.shadowRadius = 5 // 影のぼかし量
    }
    
    func setBorder(color:UIColor, lineWidth:CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = lineWidth
    }
    
    func setLightShadow(){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 0) // 影の方向(ここでは右下)
        self.layer.shadowOpacity = 0.1 // 影の濃さ
        self.layer.shadowRadius = 15 // 影のぼかし量
    }
    
    func clipAllCorner(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func clipOneSideCorner(radius:CGFloat,vec:vec){
        self.layer.cornerRadius = radius
        switch vec {
        case .UP:
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
        case .LEFT:
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = [
                    .layerMinXMinYCorner,
                    .layerMinXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
        case .RIGHT:
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = [
                    .layerMaxXMinYCorner,
                    .layerMaxXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
        case .DOWN:
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = [
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner]
            } else {
                // Fallback on earlier versions
            }
        }
        self.clipsToBounds = true
    }
    
}

enum vec{
   case UP,LEFT,RIGHT,DOWN
}

extension UIButton{
    func setButtonColor(image:UIImage,color:UIColor){
        //画像の色に左右されるのではなく形だけ画像通りにして色をプログラム側で設定する
        let backImage = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.setImage(backImage, for: .normal)
        self.tintColor = color
    }
    
    func setNormalButton(backgroundColor:UIColor,tintColor:UIColor,fontSize:CGFloat,clipRadius:CGFloat,shadow:Bool){
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.clipAllCorner(radius: clipRadius)
        if shadow { self.setShadow() }
    }
}

extension UITextView{
    func setFinishButton(){
        //キーボード上完了ボタン//
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action:#selector(commitButtonTapped))
        
        kbToolBar.items = [spacer, commitButton]
        
        self.inputAccessoryView = kbToolBar
    }
    
    @objc func commitButtonTapped (){
        self.endEditing(true)
    }
}

extension UITextField{
    func setFinishButton(){
        //キーボード上完了ボタン//
        // 仮のサイズでツールバー生成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action:#selector(commitButtonTapped))
        
        kbToolBar.items = [spacer, commitButton]
        
        self.inputAccessoryView = kbToolBar
    }
    
    @objc func commitButtonTapped (){
        self.endEditing(true)
    }
}

extension String {
    public func isOnly(_ characterSet: CharacterSet) -> Bool {
        return self.trimmingCharacters(in: characterSet).count <= 0
    }
    /// 半角数字のみで構成されているかどうか
    public var isDoubleNumber: Bool {
        var caset = CharacterSet()
        caset.insert(charactersIn: "0123456789.")
        let result1 = self.isOnly(caset)

        // .が複数個含まれていないかチェック
        let result2 = !self.pregMatche(pattern: "\\..*\\.")
        
        return result1 && result2
    }
    
    mutating func deleteLastCharactor(){
        if self.count > 0{
            self = String(String(self.prefix(self.count - 1)))
        }
    }
    
    //絵文字など(2文字分)も含めた文字数を返します
    var length: Int {
        let string_NS = self as NSString
        return string_NS.length
    }

    //正規表現の検索をします
    func pregMatche(pattern: String, options: NSRegularExpression.Options = []) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, self.length))
        return matches.count > 0
    }

    //正規表現の検索結果を利用できます
    func pregMatche(pattern: String, options: NSRegularExpression.Options = [], matches: inout [String]) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return false
        }
        let targetStringRange = NSRange(location: 0, length: self.length)
        let results = regex.matches(in: self, options: [], range: targetStringRange)
        for i in 0 ..< results.count {
            for j in 0 ..< results[i].numberOfRanges {
                let range = results[i].range(at: j)
                matches.append((self as NSString).substring(with: range))
            }
        }
        return results.count > 0
    }

    //正規表現の置換をします
    func pregReplace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.length), withTemplate: with)
    }
}


extension UIView {
    
    func captureImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        
        guard let context: CGContext = UIGraphicsGetCurrentContext() else { return nil }
        
        self.layer.render(in: context)
        
        let capturedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
}

extension UITableView {
    
    var contentBottom: CGFloat {
        return contentSize.height - bounds.height
    }
    
    func captureTableViewImage() -> UIImage? {
        
        let images = captureImages()
        
        // Concatenate images
        
        UIGraphicsBeginImageContext(contentSize);
        
        var y: CGFloat = 0
        for image in images {
            image.draw(at: CGPoint(x: 0, y: y))
            y = min(y + bounds.height, contentBottom) // calculate layer diff
        }
        let concatImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return concatImage
    }
    
    func captureImages() -> [UIImage] {
        
        var images: [UIImage?] = []
        
        while true {
            
            images.append(superview?.captureImage()) // not work in self.view
            
            if contentOffset.y < (contentBottom - bounds.height) {
                contentOffset.y += bounds.height
            } else {
                contentOffset.y = contentBottom
                images.append(superview?.captureImage()) // not work in self.view
                break
            }
        }
        
        return images.compactMap{ $0 } // exclude nil
    }
}

extension UIImageView{
    func setColorImage(image:UIImage,color:UIColor){
        //画像の色に左右されるのではなく形だけ画像通りにして色をプログラム側で設定する
        if #available(iOS 13.0, *) {
            self.image = image.withTintColor(color)
        } else {
            self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }
    }
}

extension String{
    func toUrl()->URL?{
        return URL(string: self)
    }
}

extension Int{
    func toYen()->String{
        return String(self) + "円"
    }
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

extension Bool{
    func not() -> Bool { !self }
}

extension Optional{
    func notNil() -> Bool{ self != nil }
}

