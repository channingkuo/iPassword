//
//  ComposeViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 25/03/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var delegate: KPresentedOneControllerDelegate?
    var interactiveDismiss: KInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        
        self.view.backgroundColor = .white
        let cancelButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel_click), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        self.interactiveDismiss = KInteractiveTransition.init(type: .KInteractiveTransitionTypeDismiss, GestureDirection: .KInteractiveTransitionGestureDirectionDown)
        self.interactiveDismiss?.addPanGestureToViewController(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func cancel_click(){
        if (delegate != nil) && (delegate?.responds(to: #selector(TableViewController.presentedOneControllerPressedDissmiss)))! {
            delegate?.presentedOneControllerPressedDissmiss()
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KPresentTransition.transitionWithTransitionType(type: .KPresentOneTransitionTypePresent)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KPresentTransition.transitionWithTransitionType(type: .KPresentOneTransitionTypeDismiss)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        let interactivePresent: KInteractiveTransition = delegate?.interactiveTransitionForPresent() as! KInteractiveTransition
        if interactivePresent.interation == nil {
            return nil
        }
        return interactivePresent.interation! ? interactivePresent : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if interactiveDismiss?.interation == nil {
            return nil
        }
        return (interactiveDismiss?.interation)! ? interactiveDismiss : nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

protocol KPresentedOneControllerDelegate: NSObjectProtocol {
    func presentedOneControllerPressedDissmiss()
    func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning
}
