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
        self.rightButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(TableViewController.newone))
        self.navigationItem.setRightBarButton(self.rightButtonItem, animated: true)
        
        self.interactivePush = KInteractiveTransition.initWithTransitionTypeAndDirection(type: .KInteractiveTransitionTypePresent, GestureDirection: .KInteractiveTransitionGestureDirectionUp)
//        self.interactivePush?.presentConfig = { [weak self] in
//            self?.newone()
//        }
//        self.interactivePush?.addPanGestureToViewController(vc: self.navigationController!)
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
   
//        // setup pan/tap gesture to the view
//        self.tapGesture.addTarget(self, action: #selector(TableViewController.tapGesture_Clicked))
//        self.panGesture.addTarget(self, action: #selector(TableViewController.panGesture_drag))
//        self.topTitleView.addGestureRecognizer(self.panGesture)
    
    /// view pan gesture
    ///
    /// - Parameter sender:
//    @objc func panGesture_drag(sender : UIPanGestureRecognizer) {
//        let translation = sender.translation(in: self.view)
//        self.popedView.frame.origin.y += translation.y
//        // TODO 移动过程中self.view的3D旋转动画
//        sender.setTranslation(CGPoint.zero, in: self.view)
//
//        if sender.state == .ended {
//            if (self.popedView.frame.origin.y > UIScreen.main.bounds.size.height / 2) && (self.popedView.frame.origin.y != 50) {
//                if UIDevice().deviceName == "iPhone X" || (UIDevice().deviceName == "Simulator" && UIDevice().systemVersion == "11.2") {
//                    self.popedView.frame.origin.y = UIScreen.main.bounds.size.height - 60
//                    self.popedView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
//                } else {
//                    self.popedView.frame.origin.y = UIScreen.main.bounds.size.height - 50
//                }
//                // 设置最小化后的编辑页面
//                self.setupFinalSite()
//
//                if UIDevice().deviceName == "iPhone X" || (UIDevice().deviceName == "Simulator" && UIDevice().systemVersion == "11.2") {
//                    self.view.frame.size.height -= 62
//                } else {
//                    self.view.frame.size.height -= 52
//                }
//                self.view.layer.cornerRadius = 8.0
//
//                // 移除拖拽手势控件
//                self.topTitleView.removeGestureRecognizer(self.panGesture)
//                // 设置最小化后的view的点击事件————还原到编辑状态
//                self.topTitleView.addGestureRecognizer(self.tapGesture)
//                // 隐藏部分按钮
//                self.cancelButton.isHidden = true
//                self.saveButton.isHidden = true
//                self.strightLine.isHidden = true
//                self.popMin = true
//            } else {
//                self.popedView.frame.origin.y = 50
//                self.popMin = false
//            }
//        }
//    }
    
    /// view tap gesture
    ///
    /// - Parameter sender:
//    @objc func tapGesture_Clicked(sender : UITapGestureRecognizer) {
//        self.topTitleView.removeGestureRecognizer(self.tapGesture)
//        self.topTitleView.addGestureRecognizer(self.panGesture)
//
//        if UIDevice().deviceName == "iPhone X" || (UIDevice().deviceName == "Simulator" && UIDevice().systemVersion == "11.2") {
//            self.view.frame.size.height += 62
//            self.popedView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 0.85)
//        } else {
//            self.view.frame.size.height += 52
//        }
//
//        // 显示部分按钮
//        self.cancelButton.isHidden = false
//        self.saveButton.isHidden = false
//        self.strightLine.isHidden = false
//
//        self.setupMaximize(minimize: self.popMin)
//
//        self.popMin = false
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
