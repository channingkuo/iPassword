//
//  HomeViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/19.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    var infos: Array<DataInfoModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        //TODO 从本地数据库中获取数据
        self.infos.append(DataInfoModel(caption: "Cell text1", account: "Cell Subtitle"))
        self.infos.append(DataInfoModel(caption: "Cell text2", account: "Cell Subtitle"))
        self.infos.append(DataInfoModel(caption: "Cell text3", account: "Cell Subtitle"))
        self.infos.append(DataInfoModel(caption: "Cell text4", account: "Cell Subtitle"))
        self.infos.append(DataInfoModel(caption: "Cell text5", account: "Cell Subtitle"))
        self.infos.append(DataInfoModel(caption: "Cell text6", account: "Cell Subtitle"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil)
        cell.textLabel!.text = "Cell text"
        cell.detailTextLabel?.text = "Cell Subtitle"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != UITableViewCellEditingStyle.delete{
            return
        }
        //TODO 删掉一条数据
    }
}

