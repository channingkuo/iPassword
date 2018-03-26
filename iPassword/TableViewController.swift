//
//  TableViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 20/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, KPresentedOneControllerDelegate {
//    @IBOutlet var tapGesture: UITapGestureRecognizer!
//    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet var tableview: UITableView!
    var rightButtonItem = UIBarButtonItem()
    
    var interactivePush: KInteractiveTransition?
    
//    var topTitleView = UIView(), popedView = UIView()
//    var strightLine = UIView()
//    var cancelButton = UIButton()
//    var saveButton = UIButton()
    
    //  popview pushed    editview edit   popview min
//    var isPushed = false, isEdit = false, popMin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.view.layer.cornerRadius = 10
        self.navigationController?.view.layer.masksToBounds = true
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
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
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
        self.interactivePush?.presentConfig = { [weak self] in
            self?.newone()
        }
//        self.interactivePush?.addPanGestureToViewController(vc: self.navigationController!)
        
//        self.setupPopView()
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
        let composeVc = ComposeViewController()
        composeVc.delegate = self
        self.present(composeVc, animated: true, completion: nil)
    }
    
    @objc func presentedOneControllerPressedDissmiss() {
        self.dismiss(animated: true, completion: nil)
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
    
    /// pop the pop view
//    @objc func cancelButton_Clicked() -> Void {
//        self.isPushed = false
//        self.rightButtonItem.isEnabled = true
//
//        self.view.layer.cornerRadius = 0.0
//
//        self.pop()
//
//        self.topTitleView.removeGestureRecognizer(self.tapGesture)
//        self.topTitleView.addGestureRecognizer(self.panGesture)
//    }
    
    /// save the password
//    @objc func saveButton_Clicked() -> Void {
//
//    }
    
    /// 新增编辑页面的基础设置
//    func setupPopView() -> Void {
//        /// setup viewcontroller pop up
//        self.popedView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 50))
//        self.popedView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 0.85)
//        // setup shadow
//        self.popedView.layer.shadowColor = UIColor.black.cgColor
//        self.popedView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
//        self.popedView.layer.shadowOpacity = 0.8
//        self.popedView.layer.shadowRadius = 5
//        // top title(NavigationBar) view
//        self.topTitleView = UIView(frame: CGRect(x: 0, y: 0, width: self.popedView.frame.width, height: 50))
//        self.topTitleView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
//        self.topTitleView.layer.cornerRadius = 8.0
//        self.popedView.addSubview(self.topTitleView)
//        // pop button
//        self.cancelButton = UIButton(frame: CGRect(x: 10, y: 10, width: 60, height: 30))
//        self.cancelButton.setTitle("Cancel", for: .normal)
//        self.cancelButton.addTarget(self, action: #selector(TableViewController.cancelButton_Clicked), for: .touchUpInside)
//        // save button
//        self.saveButton = UIButton(frame: CGRect(x: self.topTitleView.frame.width - 10 - 60, y: 10, width: 60, height: 30))
//        self.saveButton.setTitle("Save", for: .normal)
//        self.saveButton.setTitleColor(.lightGray, for: .disabled)
//        self.saveButton.setTitleColor(.white, for: .normal)
//        self.saveButton.isEnabled = false
//        self.saveButton.addTarget(self, action: #selector(TableViewController.saveButton_Clicked), for: .touchUpInside)
//        // title view
//        let passwordLabel = UILabel(frame: CGRect(x: 0, y: 15, width: self.topTitleView.frame.width, height: 30))
//        passwordLabel.text = "New Password"
//        passwordLabel.textColor = .white
//        passwordLabel.textAlignment = .center
//        passwordLabel.attributedText = NSAttributedString(string: "New Password", attributes: [NSAttributedStringKey.font: UIFont(name: "Zapfino", size: 14.0)!])
//        // stright line
//        self.strightLine = UIView(frame: CGRect(x: (self.topTitleView.frame.width - 50) / 2, y: 4, width: 50, height: 6))
//        self.strightLine.backgroundColor = UIColor(red: 207 / 255, green: 205 / 255, blue: 209 / 255, alpha: 1)
//        self.strightLine.layer.cornerRadius = 3.0
//        // override bottom corner radius
//        let overrideView = UIView(frame: CGRect(x: 0, y: 40, width: self.topTitleView.frame.width, height: 10))
//        overrideView.backgroundColor = UIColor(red: 246 / 255, green: 225 / 255, blue: 127 / 255, alpha: 1)
//        self.topTitleView.addSubview(self.cancelButton)
//        self.topTitleView.addSubview(self.saveButton)
//        self.topTitleView.addSubview(passwordLabel)
//        self.topTitleView.addSubview(overrideView)
//        self.topTitleView.addSubview(self.strightLine)
//
//        self.createPopViewController(self.navigationController!, popView: self.popedView)
//
//        // setup pan/tap gesture to the view
//        self.tapGesture.addTarget(self, action: #selector(TableViewController.tapGesture_Clicked))
//        self.panGesture.addTarget(self, action: #selector(TableViewController.panGesture_drag))
//        self.topTitleView.addGestureRecognizer(self.panGesture)
//    }
    
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
