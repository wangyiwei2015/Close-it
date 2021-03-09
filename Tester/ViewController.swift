//
//  ViewController.swift
//  Tester
//
//  Created by Wangyiwei on 2020/3/14.
//  Copyright © 2020 Wangyiwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    let hapticBig = UIImpactFeedbackGenerator(style: .heavy)
    let hapticSmall = UIImpactFeedbackGenerator(style: .light)
    override var prefersHomeIndicatorAutoHidden: Bool {return true}
    var homeBtnTimer: Timer?
    var homeBtnTapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.clipsToBounds = true
        btn.layer.cornerRadius = btn.frame.height / 2
        btn.backgroundColor = UIColor(white: 0, alpha: 0.01)
        btn.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
        hapticBig.prepare()
        hapticSmall.prepare()
    }
    
    func goToHomeGracefully() {
        let app = UIApplication.shared
        let selector = NSSelectorFromString("suspend")
        app.perform(selector, with: app, with: selector)
        //MagicLauncher.gotoHome()
    }
    
    @objc func action(_ sender: UIButton) {
        hapticSmall.impactOccurred()
        homeBtnTimer?.invalidate()
        self.homeBtnTapCount += 1
        homeBtnTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {_ in
            if(self.homeBtnTapCount == 1) {
                //Home
                print(1)
                self.goToHomeGracefully()
            } else if(self.homeBtnTapCount == 2) {
                //AppSwitcher
                print(2)
                self.alert("App Switcher")
            } else if(self.homeBtnTapCount == 3) {
                //Accessibility
                print(3)
                self.alert("Accessibility Menu")
            }
            self.homeBtnTapCount = 0
        })
    }
    
    func alert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchDownHomeBtn(_ sender: UIButton) {
        hapticBig.impactOccurred()
        homeBtnTimer?.invalidate()
        homeBtnTimer = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false, block: {_ in
            self.homeBtnTapCount = -1
            //Siri
        })
    }
    
    @IBAction func leaveOutside(_ sender: Any) {
        homeBtnTimer?.invalidate()
        self.homeBtnTapCount = 0
    }
}

