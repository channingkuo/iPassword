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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "PswwordKeeper"
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        // 去掉tableView下面多余空行的分割线
        self.tableView.tableFooterView = UIView()
        
        //TODO 从本地数据库中获取数据
        let info1 = DataInfoModel(key: UUID().uuidString)
        info1.index = 1
        info1.account = "492689363"
        info1.caption = "QQ"
        info1.iconName = "default_icon.png"
        info1.lastEditTime = NSDate()
        info1.password = "1234567890"
        let info2 = DataInfoModel(key: UUID().uuidString)
        info2.index = 0
        info2.account = "wangji-_--"
        info2.caption = "WeChat"
        info2.iconName = "default_icon.png"
        info2.lastEditTime = NSDate()
        info2.password = "123457890"
        let info3 = DataInfoModel(key: UUID().uuidString)
        info3.index = 2
        info3.account = "channingwei"
        info3.caption = "GitHub"
        info3.iconName = "default_icon.png"
        info3.lastEditTime = NSDate()
        info3.password = "1234567890"
        
        infos += [info1, info2, info3]
        
        if infos.count == 0 {
            let bgView = UILabel(frame: CGRect(x: 0, y: self.tableView.bounds.height / 2, width: self.tableView.bounds.width, height: 20))
            bgView.text = "还没有记录，赶紧去添加吧..."
            bgView.textAlignment = NSTextAlignment.center
            bgView.textColor = UIColor.init(red: 136, green: 136, blue: 136, alpha: 0)
            self.tableView.backgroundView = bgView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        return infos.count
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
        // TODO 详细内容
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

