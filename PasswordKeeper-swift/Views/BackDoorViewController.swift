//
//  BackDoorViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2017/1/9.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit
import Alamofire

class BackDoorViewController: UITableViewController {
    
    var backDoorData: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "BackDoor"
        self.tableView.tableFooterView = UIView()
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        
        // 开启后门
        let itemButton = UIBarButtonItem(title: "OpenDoor", style: .plain, target: self, action: #selector(BackDoorViewController.openBackDoor))
        navigationItem.setRightBarButton(itemButton, animated: false)
    }
    
    func openBackDoor() {
        print("开始执行后门程序...")
        
        var serverAddress: String = ""
        let inputAlert = UIAlertController.init(title: "Server Address", message: nil, preferredStyle: .alert)
        inputAlert.addTextField(configurationHandler: {(serverAddress: UITextField!) in
            serverAddress.placeholder = "Server Address"
            serverAddress.keyboardType = UIKeyboardType.URL
            serverAddress.text = "http://192.168.0.110:1222/"
        })
        let actionOK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action in
            // 添加菊花
            let activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2, width: 10, height: 10))
            activityIndicator.activityIndicatorViewStyle = .gray
            activityIndicator.hidesWhenStopped = true
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            serverAddress = (inputAlert.textFields?[0].text)!
            let url = serverAddress + "api/BackDoor/OpenBackDoor"
            Alamofire.request(url, method: .get).responseJSON(completionHandler: {
                response in
                // 去掉菊花
                activityIndicator.stopAnimating()
                
                if let JSON = response.result.value {
                    self.backDoorData = JSON
                    print("JSON: \(JSON)")
                }
            })
        }
        inputAlert.addAction(actionOK)
        present(inputAlert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.backDoorData as! [BackDoorModel]).count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if (self.backDoorData as! [BackDoorModel]).count < indexPath.row {
            return UITableViewCell()
        }
        let info = (self.backDoorData as! [BackDoorModel])[indexPath.row]
        let cellIdentifier = info.key
        
//        if infoInTableRows.count < indexPath.row {
//            return UITableViewCell()
//        }
//        let info = infoInTableRows[indexPath.row]
//        let cellIdentifier = info["key"] as? String
//        let cell: TableViewCell = TableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier) as UITableViewCell as! TableViewCell
//        cell.updateUIInformation(info: info)
//        return cell
        return UITableViewCell()
    }
    
    // 选择row，触发出现全选
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    class BackDoorModel {
        var caption: String?
        var account: String?
        var password: String?
        var iconName: String?
        var lastEditTime: NSDate?
        var remark: String?
        var key: String?
        var indexKey: String?
    }
}
