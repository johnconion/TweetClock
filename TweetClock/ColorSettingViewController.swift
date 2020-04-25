//
//  ColorSettingViewController.swift
//  TweetClock
//
//  Created by Ryosuke Tamura on 2020/04/25.
//  Copyright © 2020 Ryosuke Tamura. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ColorSettingViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    
    var type : ColorSettingType!
    
    private let backgroundColorStore = BackgroundColorStore.shared
    private let textColorStore = TextColorStore.shared
    
    private var color = BehaviorRelay<Color>(value: Color())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        color.subscribe(){ _ in
            self.colorView.backgroundColor = UIColor(displayP3Red: self.color.value.getRedValue(),
                                                     green: self.color.value.getGreenValue(),
                                                     blue: self.color.value.getBlueValue(),
                                                     alpha: 1.0)
        }.disposed(by: disposeBag)
        
        setLayout()
    }
    
    @IBAction func redSlider(_ sender: UISlider) {
        color.accept(color.value.setRedValue(r: sender.value))
    }
    
    @IBAction func greenSlider(_ sender: UISlider) {
        color.accept(color.value.setGreenValue(g: sender.value))
    }
    
    @IBAction func blueSlider(_ sender: UISlider) {
        color.accept(color.value.setBlueValue(b: sender.value))
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if(self.type == ColorSettingType.BACKGROUND){
            UserDefaultManager.setValue(key: .BackgroundRedColor, value: self.color.value.getRedValue())
            UserDefaultManager.setValue(key: .BackgroundGreenColor, value: self.color.value.getGreenValue())
            UserDefaultManager.setValue(key: .BackgroundBlueColor, value: self.color.value.getBlueValue())
        }else if(self.type == ColorSettingType.TEXT){
            UserDefaultManager.setValue(key: .TextRedColor, value: self.color.value.getRedValue())
            UserDefaultManager.setValue(key: .TextGreenColor, value: self.color.value.getGreenValue())
            UserDefaultManager.setValue(key: .TextBlueColor, value: self.color.value.getBlueValue())
        }
        dismiss(animated: true, completion: nil)
    }
}

private extension ColorSettingViewController{
    func setLayout(){
        
        if(self.type == ColorSettingType.BACKGROUND){
            color.accept(backgroundColorStore.value)
            colorView.backgroundColor = UIColor(displayP3Red: backgroundColorStore.value.getRedValue(), green: backgroundColorStore.value.getGreenValue(), blue: backgroundColorStore.value.getBlueValue(), alpha: 1.0)
            setSlider(r: backgroundColorStore.value.getRedValue(), g: backgroundColorStore.value.getGreenValue(), b: backgroundColorStore.value.getBlueValue())
        }else if(self.type == ColorSettingType.TEXT){
            color.accept(textColorStore.value)
            colorView.backgroundColor = UIColor(displayP3Red: textColorStore.value.getRedValue(), green: textColorStore.value.getGreenValue(), blue: textColorStore.value.getBlueValue(), alpha: 1.0)
            setSlider(r: textColorStore.value.getRedValue(), g: textColorStore.value.getGreenValue(), b: textColorStore.value.getBlueValue())
        }
        
        saveButton.setNormalButton(backgroundColor: UIColor(named: "save_button_color")!, tintColor: .white, fontSize: 17, clipRadius: 5, shadow: true)
    }
    
    func setSlider(r:CGFloat,g:CGFloat,b:CGFloat){
        redSlider.setValue(Float(r), animated: true)
        greenSlider.setValue(Float(g), animated: true)
        blueSlider.setValue(Float(b), animated: true)
    }
}

enum ColorSettingType {
    case BACKGROUND
    case TEXT
}
