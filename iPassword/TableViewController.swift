//
//  TableViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 20/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, KPresentedOneControllerDelegate {
    @IBOutlet var tableview: UITableView!
    var rightButtonItem = UIBarButtonItem()
    
    var interactivePush: KInteractiveTransition?
    var minimizeView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
//        if #available(iOS 11.0, *) {
//            self.tableview.contentInsetAdjustmentBehavior = .never
//        } else {
//            // Fallback on earlier versions
//        }
//        self.tableview.backgroundColor = .white
//        self.tableview.estimatedRowHeight = 0
//        self.tableview.estimatedSectionFooterHeight = 0
//        self.tableview.estimatedSectionHeaderHeight = 0
        
        /// setup iOS 11 NavigationBar style
        self.navigationItem.title = "iPassword"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 243 / 255, green: 214 / 255, blue: 116 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = {[
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 18.0)!
            ]}()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationController?.navigationBar.largeTitleTextAttributes = {[
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 20.0)!
                ]}()
        } else {
            // Fallback on earlier versions
        }
        self.rightButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newone))
        self.navigationItem.setRightBarButton(self.rightButtonItem, animated: true)
        
        self.interactivePush = KInteractiveTransition.initWithTransitionTypeAndDirection(type: .KInteractiveTransitionTypePresent, GestureDirection: .KInteractiveTransitionGestureDirectionUp, delegate: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// setup iOS 11 NavigationBar style
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc func newone() -> Void {
        // 设置view的圆角
        self.navigationController?.view.layer.cornerRadius = 10
        self.navigationController?.view.layer.masksToBounds = true
        
        let composeVc = ComposeViewController()
        composeVc.delegate = self
        self.present(composeVc, animated: true, completion: nil)
    }
    
    @objc func presentedOneControllerPressedDissmiss() {
        self.dismiss(animated: true, completion: nil)
        
        // 恢复view的圆角
        self.navigationController?.view.layer.cornerRadius = 0
        self.navigationController?.view.layer.masksToBounds = false
    }
    
    func interactiveTransitionForPresent() -> UIViewControllerInteractiveTransitioning {
        return self.interactivePush!
    }
    
    /// 最小化页面后设置self.view的圆角
    func recoveryTheCornerRadius() {
        // 恢复view的圆角
        self.navigationController?.view.layer.cornerRadius = 0
        self.navigationController?.view.layer.masksToBounds = false
        // 左下、右下添加圆角
        let frame = CGRect(x: (self.navigationController?.view.bounds.origin.x)!, y: (self.navigationController?.view.bounds.origin.y)!, width: (self.navigationController?.view.bounds.width)!, height: (self.navigationController?.view.bounds.height)! - 50)
        let maskPath = UIBezierPath.init(roundedRect: frame, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.bottomLeft.rawValue) | UInt8(UIRectCorner.bottomRight.rawValue))), cornerRadii: CGSize.init(width: 10, height: 10))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = frame
        maskLayer.path = maskPath.cgPath
        self.navigationController?.view.layer.mask = maskLayer
    }
    
    /// 添加最小化页面
    func minimizeTheView() {
        // 设置minimize view
        let windowFrame = UIApplication.shared.delegate?.window??.frame
        self.minimizeView = UIView(frame: CGRect(x: 0, y: (windowFrame?.height)! - 50, width: self.view.frame.width, height: 50))
        self.minimizeView?.backgroundColor = UIColor(red: 243 / 255, green: 214 / 255, blue: 116 / 255, alpha: 1)
        let minimizeTitle = UILabel(frame: CGRect(x: 0, y: 15, width: (self.minimizeView?.frame.width)!, height: 30))
        minimizeTitle.text = "New Password"
        minimizeTitle.textColor = .white
        minimizeTitle.textAlignment = .center
        minimizeTitle.attributedText = NSAttributedString(string: (minimizeTitle.text)!, attributes:[NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 14.0)!])
        self.minimizeView?.addSubview(minimizeTitle)
        self.minimizeView?.tag = 1
        let maskPath = UIBezierPath.init(roundedRect: (self.minimizeView?.bounds)!, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue))), cornerRadii: CGSize.init(width: 10, height: 10))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = (self.minimizeView?.bounds)!
        maskLayer.path = maskPath.cgPath
        self.minimizeView?.layer.mask = maskLayer

        self.minimizeView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureAction)))

        UIApplication.shared.delegate?.window??.addSubview(self.minimizeView!)
    }
    
    @objc func tapGestureAction(tapGesture: UITapGestureRecognizer) {
        self.navigationController?.view.frame.size.height += 50
        // 恢复self.navigationController?.view的layer高度
        let maskPath1 = UIBezierPath.init(roundedRect: (self.navigationController?.view.bounds)!, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.bottomLeft.rawValue) | UInt8(UIRectCorner.bottomRight.rawValue))), cornerRadii: CGSize.init(width: 0, height: 0))
        let maskLayer1 = CAShapeLayer.init()
        maskLayer1.frame = (self.navigationController?.view.bounds)!
        maskLayer1.path = maskPath1.cgPath
        self.navigationController?.view.layer.mask = maskLayer1
        self.minimizeView?.removeFromSuperview()
        
        self.newone()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier")
        }
        cell?.textLabel?.text = String(indexPath.row)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// 滚动试图页面，改变NavigationBar形态、ToolBar等控件
    ///
    /// - Parameter scrollView:
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
