//
//  TableViewController.swift
//  iPassword
//
//  Created by Channing Kuo on 20/02/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import UIKit
import SQLite
import DZNEmptyDataSet

class TableViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, KPresentedOneControllerDelegate {
    @IBOutlet var tableview: UITableView!
    var rightButtonItem = UIBarButtonItem()
    
    var interactivePush: KInteractiveTransition?
    var minimizeView: UIView?
    
    // data rows
    var datatable: Array<SQLite.Row>!
    var searchDataTable: Array<SQLite.Row>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.tableview.emptyDataSetDelegate = self
        self.tableview.emptyDataSetSource = self
        
        self.tableview.tableFooterView = UIView()
        
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
            NSAttributedStringKey.font: UIFont(name: "PingFang SC", size: 20.0)!
            ]}()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
            self.navigationController?.navigationBar.largeTitleTextAttributes = {[
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.font: UIFont(name: "PingFang SC", size: 22.0)!
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
        
        // 获取 data row
        self.datatable = Array(try! SQLiteUtils.db.prepare(SQLiteUtils.table))
        
//        try! SQLiteUtils.db.run(SQLiteUtils.table.insert(SQLiteUtils.title <- "test", SQLiteUtils.account <- "test@test.com", SQLiteUtils.password <- "1234567", SQLiteUtils.icon <- "default.png", SQLiteUtils.modifytime <- "2018-04-14 23:10:10", SQLiteUtils.remark <- "tettttdfghjk", SQLiteUtils.index <- 0, SQLiteUtils.id <- UUID().uuidString))
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        
        self.searchDataTable = self.datatable.filter({ (row) -> Bool in
            return row[SQLiteUtils.title].contains(searchString) || row[SQLiteUtils.account].contains(searchString) || row[SQLiteUtils.remark].contains(searchString)
        })
        
        self.tableview.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @objc func newone() -> Void {
        // 设置view的圆角
        self.navigationController?.view.layer.cornerRadius = 10
        self.navigationController?.view.layer.masksToBounds = true
        
        // 从缓存表中取数据，若有缓存数据则把数据id传给ComposeViewController
        let row = try! SQLiteUtils.db.pluck(SQLiteUtils.bufferTable)
        
        var composeVc: ComposeViewController
        if row != nil {
            print("test1")
            composeVc = ComposeViewController.init(rowId: row?[SQLiteUtils.id])
        }
        print("test2")
        composeVc = ComposeViewController.init(rowId: nil)
        composeVc.delegate = self
        self.present(composeVc, animated: true, completion: nil)
    }
    
    @objc func presentedOneControllerPressedDissmiss() {
        self.dismiss(animated: true, completion: nil)
        
        // 恢复view的圆角
        self.navigationController?.view.layer.cornerRadius = 0
        self.navigationController?.view.layer.masksToBounds = false
        
        // 恢复新建按钮
        self.rightButtonItem.isEnabled = true
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
        let frame = CGRect(x: (self.navigationController?.view.bounds.origin.x)!, y: (self.navigationController?.view.bounds.origin.y)!, width: (self.navigationController?.view.bounds.width)!, height: (self.navigationController?.view.bounds.height)! - GlobalAppSetting.minimizeViewHeight)
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
        self.minimizeView = UIView(frame: CGRect(x: 0, y: (windowFrame?.height)! - GlobalAppSetting.minimizeViewHeight, width: self.view.frame.width, height: GlobalAppSetting.minimizeViewHeight))
        self.minimizeView?.backgroundColor = UIColor(red: 243 / 255, green: 214 / 255, blue: 116 / 255, alpha: 1)
        let minimizeTitle = UILabel(frame: CGRect(x: 0, y: 15, width: (self.minimizeView?.frame.width)!, height: 30))
        minimizeTitle.text = "New Password"
        minimizeTitle.textColor = .white
        minimizeTitle.textAlignment = .center
        minimizeTitle.attributedText = NSAttributedString(string: (minimizeTitle.text)!, attributes:[NSAttributedStringKey.font: UIFont(name: "PingFang SC", size: 16.0)!])
        self.minimizeView?.addSubview(minimizeTitle)
        self.minimizeView?.tag = 1
        let maskPath = UIBezierPath.init(roundedRect: (self.minimizeView?.bounds)!, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.topRight.rawValue))), cornerRadii: CGSize.init(width: 10, height: 10))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = (self.minimizeView?.bounds)!
        maskLayer.path = maskPath.cgPath
        self.minimizeView?.layer.mask = maskLayer

        self.minimizeView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureAction)))

        UIApplication.shared.delegate?.window??.addSubview(self.minimizeView!)
        
        // 禁用新建按钮
        self.rightButtonItem.isEnabled = false
    }
    
    @objc func tapGestureAction(tapGesture: UITapGestureRecognizer) {
        self.navigationController?.view.frame.size.height += GlobalAppSetting.minimizeViewHeight
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
        if(self.datatable == nil){
            return 0;
        }
        if #available(iOS 11.0, *) {
            if navigationItem.searchController?.isActive == true {
                return self.searchDataTable.count
            } else {
                return self.datatable.count
            }
        } else {
            return self.datatable.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GlobalAppSetting.tableRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.datatable.count < indexPath.row {
            return RowTableViewCell()
        }
        var row: SQLite.Row
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            if navigationItem.searchController?.isActive == true {
                row = self.searchDataTable[indexPath.row]
            } else {
                row = self.datatable[indexPath.row]
            }
        } else {
            row = self.datatable[indexPath.row]
        }
        let cellIdentifier = row[SQLiteUtils.id]
        let cell: RowTableViewCell = RowTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.setRowData(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 查看
        var row: SQLite.Row
        if #available(iOS 11.0, *) {
            if navigationItem.searchController?.isActive == true {
                row = self.searchDataTable[indexPath.row]
            } else {
                row = self.datatable[indexPath.row]
            }
        } else {
            row = self.datatable[indexPath.row]
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != UITableViewCellEditingStyle.delete{
            return
        }
        
        if self.datatable.count < indexPath.row {
            return
        }
        // 删掉一条数据
        let row = self.datatable[indexPath.row]
        for (index, value) in self.datatable.enumerated() {
            if value[SQLiteUtils.id] == row[SQLiteUtils.id] {
                self.datatable.remove(at: index)
                break
            }
        }

        // 同步SQLite数据库
        try! SQLiteUtils.db.run(SQLiteUtils.table.filter(SQLiteUtils.id == row[SQLiteUtils.id]).delete())

        self.tableview.reloadData()
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "你好，我的名字叫辛巴！！"
        
        let paragraph = NSMutableParagraphStyle.init()
        paragraph.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraph.alignment = NSTextAlignment.center
        
        let attributes = {[
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.darkGray,
            NSAttributedStringKey.paragraphStyle: paragraph
            ]}
        return NSAttributedString(string: text, attributes: attributes())
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Empty"
        let attributes = {[
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor: UIColor.red
            ]}
        return NSAttributedString(string: title, attributes: attributes())
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "default")
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
