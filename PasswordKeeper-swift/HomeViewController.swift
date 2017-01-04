//
//  HomeViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/19.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UITableViewController {
    
    var infos = [DataInfoModel]()
    var infoInTableRows = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "PasswordKeeper"
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        // 去掉tableView下面多余空行的分割线
        self.tableView.tableFooterView = UIView()
        
        // 新增按钮
        let itemButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(HomeViewController.pushInReadWriteView))
        navigationItem.setRightBarButton(itemButton, animated: false)
        // 设置所有的导航栏返回按钮的title
        let item = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = item;
    }
    
    func pushInReadWriteView() {
        navigationController?.pushViewController(ReadWriteViewContrller(viewTitle: "", dataInfoKey: ""), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if infos.count < indexPath.row {
            return UITableViewCell()
        }
        
        let info = infos[indexPath.row]
        let cellIdentifier = info.key
        let cell: TableViewCell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier) as UITableViewCell as! TableViewCell
        cell.updateUIInformation(info: info)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if infos.count < indexPath.row {
            return
        }
        _ = infos[indexPath.row]
        // 详细内容
        navigationController?.pushViewController(ReadWriteViewContrller(viewTitle: "", dataInfoKey: ""), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != UITableViewCellEditingStyle.delete{
            return
        }
        
        if infos.count < indexPath.row {
            return
        }
        //TODO 删掉一条数据
        let info = infos[indexPath.row]
        for (index, value) in infos.enumerated() {
            if value.key == info.key {
                infos.remove(at: index)
            }
        }
        if infos.count == 0 {
            let bgView = UILabel(frame: CGRect(x: 0, y: self.tableView.bounds.height / 2, width: self.tableView.bounds.width, height: 20))
            bgView.text = "还没有记录，赶紧去添加吧..."
            bgView.textAlignment = NSTextAlignment.center
            bgView.textColor = UIColor.init(red: 136, green: 136, blue: 136, alpha: 1)
            self.tableView.addSubview(bgView)
        }
        self.tableView.reloadData()
    }
}

