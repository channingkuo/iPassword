//
//  BackDoorViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2017/1/9.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BackDoorViewController: UITableViewController {
    
    var backDoorData: JSON = []
    var numOfRow: Int = 0
    var loadingText: UILabel?
    var isInEditing: Bool = false
    
    var selectedItem: [Int] = []
    
    var itemButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "BackDoor"
        self.tableView.tableFooterView = UIView()
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        
        // 开启后门
        itemButton = UIBarButtonItem(title: "OpenDoor", style: .plain, target: self, action: #selector(BackDoorViewController.openBackDoor))
        navigationItem.setRightBarButton(itemButton!, animated: false)
        
        self.tableView?.allowsMultipleSelectionDuringEditing = true
        
        // 绑定对长按的响应
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(_: )))
        longPress.minimumPressDuration = 1.0
        // 将长按手势添加到需要实现长按操作的视图里
        self.tableView!.addGestureRecognizer(longPress)
    }
    
    // tableViewCell长安事件
    func cellLongPressed(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            // 在正常状态和编辑状态之间切换
            if self.tableView!.isEditing == false {
                itemButton?.title = "Select All"
                self.isInEditing = true
                self.tableView!.setEditing(true, animated: true)
            }
            else {
                itemButton?.title = "OpenDoor"
                self.isInEditing = false
                self.tableView!.setEditing(false, animated: true)
            }
        }
    }
    
    func openBackDoor() {
        // 编辑处理cell，或开启BackDoor
        if self.self.isInEditing {
            //TODO 全选
        }
        else {
            print("开始执行后门程序...")
            
            var serverAddress: String = ""
            let inputAlert = UIAlertController.init(title: "Server Address", message: nil, preferredStyle: .alert)
            inputAlert.addTextField(configurationHandler: {(serverAddress: UITextField!) in
                serverAddress.placeholder = "Server Address"
                serverAddress.keyboardType = UIKeyboardType.URL
                //serverAddress.text = "http://192.168.0.110:1222/"
                serverAddress.text = "http://192.168.1.86:9990/"
            })
            let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let actionOK = UIAlertAction(title: "OK", style: .default) { action in
                // 添加菊花
                let activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: self.view.bounds.width / 2, y: self.view.bounds.height / 3, width: 10, height: 10))
                activityIndicator.activityIndicatorViewStyle = .gray
                activityIndicator.hidesWhenStopped = true
                self.view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                // 添加loading...
                self.loadingText = UILabel(frame: CGRect(x: 10, y: self.view.bounds.height / 3 + 14, width: self.view.bounds.width, height: 20))
                self.loadingText?.text = "loading..."
                self.loadingText?.textAlignment = .center
                self.view.addSubview(self.loadingText!)
                
                
                serverAddress = (inputAlert.textFields?[0].text)!
                let url = serverAddress + "api/BackDoor/OpenBackDoor"
                Alamofire.request(url, method: .get).responseJSON(completionHandler: {
                    response in
                    // 去掉菊花
                    activityIndicator.stopAnimating()
                    // 去掉loading...
                    self.loadingText?.removeFromSuperview()
                    
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        self.numOfRow = json.count
                        self.backDoorData = json
                        self.tableView.reloadData()
                        
                        print(json)
                        print(json.count)
                        print(json[0])
                        print(json[0]["key"])
                    case .failure(let error):
                        AlertControllerUtils.alertAutoDismission(title: nil, message: "The network connection was lost.", target: self)
                        print(error)
                    }
                })
            }
            inputAlert.addAction(actionCancel)
            inputAlert.addAction(actionOK)
            present(inputAlert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.numOfRow)
        return self.numOfRow
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if self.backDoorData.count < indexPath.row {
            return UITableViewCell()
        }
        let info = self.backDoorData[indexPath.row]
        let cellIdentifier = info["key"].stringValue
        
        let cell: BackDoorTableViewCell = BackDoorTableViewCell(style: .default, reuseIdentifier: cellIdentifier) as UITableViewCell as! BackDoorTableViewCell
        cell.updateUIInformation(info: info)
        return cell
    }
    
    // 选择row，并记录选中的row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem.append(indexPath.row)
    }
}
