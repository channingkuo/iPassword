//
//  ViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 18/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var leb: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        leb = UILabel(frame: CGRect(x: 10, y: 100, width: 200, height: 60))
//        leb?.text = "Good Luck!"
//        self.view.addSubview(leb!)
//        var perspectiveTransform = CATransform3DIdentity
//        perspectiveTransform.m34 = -1.0 / 2000.0
//        perspectiveTransform = CATransform3DRotate(perspectiveTransform, CGFloat.pi, 0, 1, 0)
//        let rotater = UIViewPropertyAnimator(duration: 1.0, curve: .easeIn){
//            self.leb!.layer.transform = perspectiveTransform
//        }
//        rotater.startAnimation(afterDelay: 5.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.launchAnumation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 加载自定义启动画面
    func launchAnumation() -> Void {
        let viewController = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        let launchView = viewController.view
        let mainWindow = UIApplication.shared.keyWindow
        launchView?.frame = (UIApplication.shared.keyWindow?.frame)!
        mainWindow?.addSubview(launchView!)
        
        // icon animation
        let icon = UIImageView(frame: CGRect(x: ((launchView?.frame.width)! - 160) / 2.0, y: ((launchView?.frame.height)! - 175) / 2.0, width: 160.0, height: 175.0))
        icon.image = UIImage(named: "launch-icon")
        launchView?.addSubview(icon)
        // create animation
        let rotator = CABasicAnimation(keyPath: "transform.rotation.y")
        let timingFunc = CAMediaTimingFunction(name: "easeInEaseOut")
        // set up animation property
        rotator.fromValue = 0
        rotator.toValue = CGFloat.pi * 2
        rotator.timingFunction = timingFunc
        rotator.repeatCount = MAXFLOAT
        rotator.duration = 0.7
        rotator.isRemovedOnCompletion = false
        // add animation into layer
        icon.layer.add(rotator, forKey: nil)
        
        // TODO add custom image view into current view at the launch
        
        // remove the launch view
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
        }
        animator.addCompletion { (position) in
            launchView?.removeFromSuperview()
        }
        animator.startAnimation(afterDelay: 3.0)
    }
}

