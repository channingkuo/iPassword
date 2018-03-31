//
//  KPresentTransition.swift
//  iPassword
//
//  Created by Channing Kuo on 21/03/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

/// 弹起/落下 状态
///
/// - KPresentOneTransitionType: 弹起/落下 状态
enum KPresentOneTransitionType: Int64 {
    case KPresentOneTransitionTypePresent = 0,
    KPresentOneTransitionTypeDismiss
}


/// 是通过点击按钮触发还是通过手势触发
///
/// - KPresentOneTransitionClick:
enum KPresentOneTransitionClickOrGesture: Int64 {
    case KPresentOneTransitionClick = 0,
    KPresentOneTransitionGesture
}

class KPresentTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var type: KPresentOneTransitionType?
    var invokeMethod: KPresentOneTransitionClickOrGesture?
    
    var delegate: KPresentedOneControllerDelegate?
    
    required init(type: KPresentOneTransitionType, invokeMethod: KPresentOneTransitionClickOrGesture, delegate: KPresentedOneControllerDelegate?) {
        self.type = type
        self.invokeMethod = invokeMethod
        
        self.delegate = delegate
    }
    
    class func transitionWithTransitionType(type: KPresentOneTransitionType, invokeMethod: KPresentOneTransitionClickOrGesture, delegate: KPresentedOneControllerDelegate?) -> KPresentTransition {
        return self.init(type: type, invokeMethod: invokeMethod, delegate: delegate)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 两种动画的逻辑分开
        switch (self.type) {
        case .KPresentOneTransitionTypePresent?:
            self.presentAnimation(transitionContext: transitionContext)
            break
        case .KPresentOneTransitionTypeDismiss?:
            self.dismissAnimation(transitionContext: transitionContext)
            break
        default: break
        }
    }
    
    /// present动画
    ///
    /// - Parameter transitionContext:
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning) -> Void  {
        // 通过viewControllerForKey取出转场前后的两个控制器
        let toVc = transitionContext.viewController(forKey: .to)
        let fromVc = transitionContext.viewController(forKey: .from)
        
        // snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对fromVc做动画，
        // 因为在手势过渡中直接使用fromVc动画会和手势有冲突，如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
        
        let tempView = fromVc?.view.snapshotView(afterScreenUpdates: false)
        tempView?.frame = (fromVc?.view.frame)!
        
        // 因为对截图做动画，fromVc就可以隐藏了
        fromVc?.view.isHidden = true
        
        // 这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，
        // 可以理解containerView管理者所有做转场动画的视图
        let containerView = transitionContext.containerView
        
        // 将截图视图tempView和toVc的view都加入ContainerView中
        containerView.addSubview(tempView!)
        containerView.addSubview((toVc?.view)!)
        
        // 设置toVc的frame，因为这里toVc present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕，
        // 这里containerView的frame就是整个屏幕
        toVc?.view.frame = CGRect(x: 0, y: containerView.frame.height, width: containerView.frame.width, height: containerView.frame.height - 50)
        
        // 开始动画
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
            toVc?.view.transform = CGAffineTransform.init(translationX: 0, y: 50 - containerView.frame.height)
            tempView?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }, completion: {
            finished in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
                fromVc?.view.isHidden = false
                tempView?.removeFromSuperview()
            } else {
                transitionContext.completeTransition(true)
            }
        })
    }
    
    /// dismiss动画
    ///
    /// - Parameter transitionContext:
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) -> Void {
        // 点击取消按钮，关闭presented view
        if self.invokeMethod == .KPresentOneTransitionClick {
            let fromVc = transitionContext.viewController(forKey: .from)
            let toVc = transitionContext.viewController(forKey: .to)
            // 参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，将其取出准备动画
            let containerView = transitionContext.containerView
            let subViewsArray = containerView.subviews
            let tempView = subViewsArray[min(subViewsArray.count, max(0, subViewsArray.count - 2))]
            // 动画
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
                fromVc?.view.transform = CGAffineTransform.identity
                tempView.transform = CGAffineTransform.identity
            }, completion: {
                finished in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                } else {
                    transitionContext.completeTransition(true)
                    toVc?.view.isHidden = false
                    tempView.removeFromSuperview()
                }
            })
        } else {
            // 最小化编辑页面
            let fromVc = transitionContext.viewController(forKey: .from)
            let toVc = transitionContext.viewController(forKey: .to)
            // 参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，将其取出准备动画
            let containerView = transitionContext.containerView
            let subViewsArray = containerView.subviews
            let tempView = subViewsArray[min(subViewsArray.count, max(0, subViewsArray.count - 2))]
            // 动画
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveLinear, animations: {
                fromVc?.view.transform = CGAffineTransform.identity
                tempView.transform = CGAffineTransform.identity
            }, completion: {
                finished in
                if transitionContext.transitionWasCancelled {
                    transitionContext.completeTransition(false)
                } else {
                    transitionContext.completeTransition(true)
                    toVc?.view.isHidden = false
                    tempView.removeFromSuperview()

                    // minimize view
                    toVc?.view.frame.size.height -= 50
                    if self.delegate != nil {
                        self.delegate?.minimizeTheView()
                    }
                }
            })
        }
    }
}
