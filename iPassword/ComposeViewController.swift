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
    
    var navigationView, strightLine: UIView?
    var cancelButton, saveButton: UIButton?
    var navigatonTitle: UILabel?
    
    var clickOrGesture: KPresentOneTransitionClickOrGesture = .KPresentOneTransitionGesture
    
//    var tapGesture: UITapGestureRecognizer?
//    var panGesture: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        self.view.layer.cornerRadius = 10
        self.view.layer.masksToBounds = true
        
        self.view.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
        
        self.uiviewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KPresentTransition.transitionWithTransitionType(type: .KPresentOneTransitionTypePresent, invokeMethod: .KPresentOneTransitionClick)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KPresentTransition.transitionWithTransitionType(type: .KPresentOneTransitionTypeDismiss, invokeMethod: self.clickOrGesture)
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
    
    /// 页面组件的初始化
    func uiviewInit() {
        // navigation view
        self.navigationView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        self.navigationView?.backgroundColor = UIColor(red: 243 / 255, green: 214 / 255, blue: 116 / 255, alpha: 1)
        //        self.navigationView?.layer.shadowColor = UIColor.black.cgColor
        //        self.navigationView?.layer.shadowOffset = CGSize(width: 0.02, height: 0.02)
        //        self.navigationView?.layer.shadowOpacity = 0.8
        //        self.navigationView?.layer.shadowRadius = 1
        
        // cancel button
        self.cancelButton = UIButton(frame: CGRect(x: 10, y: 10, width: 60, height: 30))
        self.cancelButton?.setTitle("Cancel", for: .normal)
        self.cancelButton?.setTitleColor(.white, for: .normal)
        self.cancelButton?.setTitleColor(.lightGray, for: .focused)
        self.cancelButton?.setTitleColor(.lightGray, for: .selected)
        self.cancelButton?.addTarget(self, action: #selector(cancel_click), for: .touchUpInside)
        
        // save button
        self.saveButton = UIButton(frame: CGRect(x: self.view.frame.width - 10 - 60, y: 10, width: 60, height: 30))
        self.saveButton?.setTitle("Save", for: .normal)
        self.saveButton?.setTitleColor(.lightGray, for: .disabled)
        self.saveButton?.setTitleColor(.white, for: .normal)
        self.saveButton?.setTitleColor(.lightGray, for: .focused)
        self.saveButton?.setTitleColor(.lightGray, for: .selected)
        self.saveButton?.isEnabled = false
        self.saveButton?.addTarget(self, action: #selector(save_click), for: .touchUpInside)
        
        // navigation title
        self.navigatonTitle = UILabel(frame: CGRect(x: 0, y: 15, width: self.view.frame.width, height: 30))
        self.navigatonTitle?.text = "New Password"
        self.navigatonTitle?.textColor = .white
        self.navigatonTitle?.textAlignment = .center
        self.navigatonTitle?.attributedText = NSAttributedString(string: (self.navigatonTitle?.text)!, attributes: [NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 14.0)!])
        
        // stright line
        self.strightLine = UIView(frame: CGRect(x: (self.view.frame.width - 50) / 2, y: 4, width: 50, height: 6))
        self.strightLine?.backgroundColor = UIColor(red: 207 / 255, green: 205 / 255, blue: 209 / 255, alpha: 1)
        self.strightLine?.layer.cornerRadius = 3.0
        
        self.view.addSubview(self.navigationView!)
        self.view.addSubview(self.cancelButton!)
        self.view.addSubview(self.saveButton!)
        self.view.addSubview(self.navigatonTitle!)
        self.view.addSubview(self.strightLine!)
        
        self.interactiveDismiss = KInteractiveTransition.init(type: .KInteractiveTransitionTypeDismiss, GestureDirection: .KInteractiveTransitionGestureDirectionDown)
        self.interactiveDismiss?.addPanGestureToViewController(vc: self, gestureView: self.navigationView!)
    }
    
    @objc func cancel_click(){
        if (delegate != nil) && (delegate?.responds(to: #selector(TableViewController.presentedOneControllerPressedDissmiss)))! {
            self.clickOrGesture = .KPresentOneTransitionClick
            delegate?.presentedOneControllerPressedDissmiss()
        }
    }
    
    @objc func save_click(){
        
    }
}

protocol KPresentedOneControllerDelegate: NSObjectProtocol {
    func presentedOneControllerPressedDissmiss()
    func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning
}
