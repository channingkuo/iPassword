//
//  TableViewPopController.swift
//  iPassword
//
//  Created by Channing Kuo on 20/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class TableViewPopController: UIViewController {
    
    /// poped view
    var popView = UIView()
    /// root View
    var rootView = UIView()
    /// controller
    var mainViewController: UIViewController?
    /// mask View
    var maskView = UIView()
    
    func createPopViewController(_ root: UIViewController, popView: UIView) -> Void {
        self.mainViewController = root
        self.popView = popView
        
        self.createSubView()
    }
    
    func createSubView() {
        self.view.backgroundColor = .black
        mainViewController!.view.frame = self.view.bounds
        rootView = mainViewController!.view
        
//        self.maskView = UIView(frame: UIScreen.main.bounds)
//        self.maskView.backgroundColor = .clear
//        UIApplication.shared.windows[0].addSubview(self.maskView)
//        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(closeGestureAction(_: )))
//        self.maskView.addGestureRecognizer(closeGesture)
    }
    
//    @objc func closeGestureAction(_ recognizer: UITapGestureRecognizer){
//        self.pop()
//    }
    
    func push(){
        UIApplication.shared.windows[0].addSubview(popView)
        var frame = popView.frame
        frame.origin.y = self.view.bounds.size.height - self.popView.frame.size.height
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            self.rootView.layer.transform = self.firstTransform()
        }
        animator.addCompletion { (position) in
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
                self.rootView.layer.transform = self.secondTransform()
            }
            animator.addCompletion { (position) in
                // popView上升
                self.popView.frame = frame
            }
            animator.startAnimation()
        }
        animator.startAnimation()
    }
    
    func pop(){
        var frame = popView.frame
        frame.origin.y += popView.frame.size.height
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            self.popView.frame = frame
            // 改善滑动效果
            self.rootView.layer.transform = self.firstTransform()
        }
        animator.addCompletion { (position) in
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
                // 变为初始值
                self.rootView.layer.transform = CATransform3DIdentity
            }
            animator.addCompletion{ (position) in
                self.popView.removeFromSuperview()
            }
            animator.startAnimation()
        }
        animator.startAnimation()
    }
    
    func firstTransform() -> CATransform3D {
        var t1 = CATransform3DIdentity
        t1.m34 = 1.0 / -900
        //带点缩小的效果
        t1 = CATransform3DScale(t1, 0.95, 0.95, 1)
        //绕x轴旋转
        t1 = CATransform3DRotate(t1, 15.0 * CGFloat.pi/180.0, 1, 0, 0)
        return t1
    }
    
    func secondTransform() -> CATransform3D {
        var t2 = CATransform3DIdentity
        t2.m34 = 1.0 / -900
        //向上移
        t2 = CATransform3DTranslate(t2, 0, self.view.frame.size.height * (-0.08), 0)
        //第二次缩小
        t2 = CATransform3DScale(t2, 0.8, 0.8, 1)
        return t2
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
