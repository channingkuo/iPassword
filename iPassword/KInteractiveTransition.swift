//
//  KInteractiveTransition.swift
//  iPassword
//
//  Created by Channing Kuo on 20/03/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

/// 手势的方向
///
/// - KInteractiveTransitionGestureDirectionLeft: 手势的方向
enum KInteractiveTransitionGestureDirection: Int64 {
    case KInteractiveTransitionGestureDirectionLeft = 0,
    KInteractiveTransitionGestureDirectionRight,
    KInteractiveTransitionGestureDirectionUp,
    KInteractiveTransitionGestureDirectionDown
}

/// 手势控制哪种转场
///
/// - KInteractiveTransitionTypePresent: 手势控制哪种转场
enum KInteractiveTransitionType: Int64 {
    case KInteractiveTransitionTypePresent = 0,
    KInteractiveTransitionTypeDismiss,
    KInteractiveTransitionTypePush,
    KInteractiveTransitionTypePop
}

class KInteractiveTransition : UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController?
    var direction: KInteractiveTransitionGestureDirection?
    var type: KInteractiveTransitionType?
    
    var interation: Bool?
    
    var presentConfig: (() -> Void)?
    var pushConfig: (() -> Void)?
    
    var delegate: KPresentedOneControllerDelegate?
    
    required init(type: KInteractiveTransitionType, GestureDirection direction: KInteractiveTransitionGestureDirection, delegate: KPresentedOneControllerDelegate?) {
        self.direction = direction
        self.type = type
        
        self.delegate = delegate
    }

    class func initWithTransitionTypeAndDirection(type: KInteractiveTransitionType, GestureDirection direction: KInteractiveTransitionGestureDirection, delegate: KPresentedOneControllerDelegate?) -> KInteractiveTransition {
        return self.init(type: type, GestureDirection: direction, delegate: delegate)
    }
    
    /// 添加Pan手势到View
    ///
    /// - Parameter vc: UIViewController
    func addPanGestureToViewController(vc: UIViewController, gestureView: UIView) -> Void {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        self.viewController = vc
        gestureView.addGestureRecognizer(panGesture)
    }
    
    /// 手势过渡的过程
    @objc func handleGesture(panGesture: UIPanGestureRecognizer) -> Void {
        //手势百分比
        var persent: CGFloat = 0
        switch (self.direction) {
            case .KInteractiveTransitionGestureDirectionLeft?:
                let transitionX = -panGesture.translation(in: self.viewController?.view).x
                persent = transitionX / (self.viewController?.view?.frame.size.width)!
            break
            case .KInteractiveTransitionGestureDirectionRight?:
                let transitionX = panGesture.translation(in: self.viewController?.view).x
                persent = transitionX / (self.viewController?.view?.frame.size.width)!
            break
            case .KInteractiveTransitionGestureDirectionUp?:
                let transitionY = -panGesture.translation(in: self.viewController?.view).y
                persent = transitionY / (self.viewController?.view?.frame.size.height)!
            break
            case .KInteractiveTransitionGestureDirectionDown?:
                let transitionY = panGesture.translation(in: self.viewController?.view).y
                persent = transitionY / (self.viewController?.view?.frame.size.height)!
            break
            default: break
        }
        switch (panGesture.state) {
            case UIGestureRecognizerState.began:
                // 手势开始的时候标记手势状态，并开始相应的事件
                self.interation = true
                self.startGesture()
                break
            case UIGestureRecognizerState.changed:
                // 手势过程中，通过update设置pop过程进行的百分比
                self.update(persent)
                break
            case UIGestureRecognizerState.ended:
                // 手势完成后结束标记并且判断移动距离是否过半，过则finish完成转场操作，否者取消转场操作
                self.interation = false
                if persent > 0.5 {
                    self.finish()
                    
                    if self.delegate != nil {
                        self.delegate?.recoveryTheCornerRadius()
                    }
                } else {
                    self.cancel()
                }
                break
            default: break
        }
    }
    
    func startGesture() -> Void{
        switch (self.type) {
            case .KInteractiveTransitionTypePresent?:
                if presentConfig != nil {
                    presentConfig!()
                }
                break
            case .KInteractiveTransitionTypeDismiss?:
                self.viewController?.dismiss(animated: true, completion: nil)
                break
            case .KInteractiveTransitionTypePush?:
                if pushConfig != nil {
                    pushConfig!()
                }
                break
            case .KInteractiveTransitionTypePop?:
                self.viewController?.navigationController?.popViewController(animated: true)
                break
            default: break
        }
    }
}
