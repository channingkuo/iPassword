//
//  HomeViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/19.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UITableViewController, UIViewControllerPreviewingDelegate {
    
    var infoInTableRows = [[String: Any]]()
    var isFirstPinched = false
    
    // peek
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.tableView.indexPathForRow(at: location)
        if indexPath == nil {
            return nil
        }
        
        let cell = self.tableView.cellForRow(at: indexPath!)
        if cell == nil {
            return nil
        }
        let info = infoInTableRows[(indexPath?.row)!]
        let key = info["dataInfoTableId"] as? String
        let title = info["caption"] as! String
        
        // TODO peek出来的view上面导航栏没有显示，特别丑
        let readWriteViewController = ReadWriteViewContrller(viewTitle: title, dataInfoKey: key)
        readWriteViewController.preferredContentSize = CGSize.init(width: 0, height: 0)
        previewingContext.sourceRect = (cell?.frame)!
        return readWriteViewController
    }
    
    // pop
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册peek and pop
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        let backgroundView = UIView.init(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.95)
        view.addSubview(backgroundView)
        
        // 验证TouchID
        TouchIdUtils.figerprintAuthentication(localizedDescription: "prove you are me", callBack: {
            resp in
            if resp.isAuthenticated {
                backgroundView.removeFromSuperview()
                self.navigationItem.title = "iPassword"
                self.navigationController?.isNavigationBarHidden = false
            }
            else{
                AlertControllerUtils.alertAutoDismission(title: nil, message: resp.errorMsg, target: self)
            }
        })
        
        self.navigationItem.hidesBackButton = true
        // 去掉tableView下面多余空行的分割线
        self.tableView.tableFooterView = UIView()
        
        // 新增按钮
        let itemButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(HomeViewController.pushInReadWriteView))
        navigationItem.setRightBarButton(itemButton, animated: false)
        // 设置所有的导航栏返回按钮的title
        let item = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = item;
        
        // 添加后门
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(_: )))
        //let pinchGesture = UITapGestureRecognizer(target: self, action: #selector(pinchAction(_: )))
        view.addGestureRecognizer(pinchGesture)
    }
    
    // pinch手势监视事件
    func pinchAction(_ recognizer: UIPinchGestureRecognizer){
        if !self.isFirstPinched {
            navigationController?.pushViewController(BackDoorViewController(), animated: true)
        }
        self.isFirstPinched = true
    }
    
    // add按钮事件
    func pushInReadWriteView() {
        navigationController?.pushViewController(ReadWriteViewContrller(viewTitle: "New", dataInfoKey: ""), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isFirstPinched = false
        // 从本地数据库中获取数据
        infoInTableRows = SQliteRepository.getData(tableName: SQliteRepository.PASSWORDINFOTABLE)
        
        if infoInTableRows.count == 0 {
            let bgView = UILabel(frame: CGRect(x: 0, y: self.tableView.bounds.height / 2, width: self.tableView.bounds.width, height: 20))
            bgView.text = "还没有记录，赶紧去添加吧..."
            bgView.textAlignment = NSTextAlignment.center
            bgView.textColor = UIColor.init(red: 136, green: 136, blue: 136, alpha: 0)
            self.tableView.backgroundView = bgView
        }
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoInTableRows.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if infoInTableRows.count < indexPath.row {
            return UITableViewCell()
        }
        let info = infoInTableRows[indexPath.row]
        let cellIdentifier = info["key"] as? String
        let cell: TableViewCell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier) as UITableViewCell as! TableViewCell
        cell.updateUIInformation(info: info)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if infoInTableRows.count < indexPath.row {
            return
        }
        let info = infoInTableRows[indexPath.row]
        // 详细内容
        navigationController?.pushViewController(ReadWriteViewContrller(viewTitle: info["caption"] as! String, dataInfoKey: info["dataInfoTableId"] as! String?), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != UITableViewCellEditingStyle.delete{
            return
        }
        
        if infoInTableRows.count < indexPath.row {
            return
        }
        // 删掉一条数据
        let info = infoInTableRows[indexPath.row]
        for (index, value) in infoInTableRows.enumerated() {
            if value["key"] as? String == info["key"] as? String {
                self.infoInTableRows.remove(at: index)
                break
            }
        }
        
        // 同步SQlite数据库
        var cols = [ColumnType]()
        let col = ColumnType(colName: "key", colType: nil, colValue: info["key"] as? String)
        cols += [col]
        _ = SQliteRepository.delete(tableName: SQliteRepository.PASSWORDINFOTABLE, columns: cols)
        
        if infoInTableRows.count == 0 {
            let bgView = UILabel(frame: CGRect(x: 0, y: self.tableView.bounds.height / 2, width: self.tableView.bounds.width, height: 20))
            bgView.text = "还没有记录，赶紧去添加吧..."
            bgView.textAlignment = NSTextAlignment.center
            bgView.textColor = UIColor.init(red: 136, green: 136, blue: 136, alpha: 1)
            self.tableView.addSubview(bgView)
        }
        self.tableView.reloadData()
    }
}

