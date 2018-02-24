//
//  TableViewPopController.swift
//  iPassword
//
//  Created by Channing Kuo on 20/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class TableViewPopController: UIViewController {
    
    var popView = UIView()
    var rootView = UIView()
    var mainViewController: UIViewController?
    /// mask View
    var maskView = UIView()
    
    /// structor
    ///
    /// - Parameters:
    ///   - root: root viewcontroller
    ///   - popView: poped view
    func createPopViewController(_ root: UIViewController, popView: UIView) -> Void {
        self.mainViewController = root
        self.popView = popView
        
        self.view.backgroundColor = .black
        mainViewController!.view.frame = self.view.bounds
        self.rootView = mainViewController!.view
    }
    
    
    /// show the pop view
    func push() {
        UIApplication.shared.windows[0].addSubview(popView)
        
        self.popView.layer.cornerRadius = 8.0
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            self.rootView.layer.transform = self.transformToBack()
            self.popView.frame.origin.y = 50
        }
        animator.startAnimation()
    }
    
    
    /// hide the pop view
    func pop() {
        var frame = self.popView.frame
        frame.origin.y += self.popView.frame.size.height
        // 改善滑动效果
        self.rootView.layer.transform = self.transformToBack()
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            self.popView.frame = frame
            // 变为初始值
            self.rootView.layer.transform = CATransform3DIdentity
        }
        animator.addCompletion { (position) in
            self.popView.removeFromSuperview()
        }
        animator.startAnimation()
    }
    
    /// 拖拽过程中rootview的变化设置
    ///
    /// - Parameter offsetHeight: 拖拽距离
    func popWithAnimation(offsetHeight: CGFloat) {
        var transformIdentity = CATransform3DIdentity
        transformIdentity.m34 = -1.0 / 1000
        // 绕x轴反向旋转
        transformIdentity = CATransform3DRotate(transformIdentity, -5.0 * CGFloat.pi / 180.0, 1, 0, 0)
        self.rootView.layer.transform = transformIdentity
    }
    
    /// 最小化popview
    func setupFinalSite() {
        self.rootView.layer.transform = self.transformToBack()
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            // 变为初始值
            self.rootView.layer.transform = CATransform3DIdentity
        }
        animator.startAnimation()
    }
    
    /// 最大化popview
    func setupMaximize(minimize: Bool) {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
            self.rootView.layer.transform = self.transformToBack()
            self.popView.frame.origin.y = 50
        }
        animator.startAnimation()
    }
    
    /// animation
    ///
    /// - Returns: CATransform3D
    func transformToBack() -> CATransform3D {
        var transformIdentity = CATransform3DIdentity
        transformIdentity.m34 = -1.0 / 1000
        // 绕x轴旋转
        transformIdentity = CATransform3DRotate(transformIdentity, 5.0 * CGFloat.pi / 180.0, 1, 0, 0)
        // 往负z方向平移
        let offset_z = 1 / 4 * self.view.frame.size.height * sin(5.0 * CGFloat.pi / 180.0)
        transformIdentity = CATransform3DTranslate(transformIdentity, 0, 0, -offset_z * 2)
        return transformIdentity
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
