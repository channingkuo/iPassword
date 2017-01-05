//
//  ReadWriteViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2017/1/4.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit

class ReadWriteViewContrller: UIViewController {
    
    let viewTitle: String
    var dataInfoKey: String? = ""
    
    var border1, border2, border3: UILabel?
    var caption, account, password: UITextField?
    var remark: UITextView?
    
    init(viewTitle: String, dataInfoKey: String?) {
        self.viewTitle = viewTitle
        self.dataInfoKey = dataInfoKey
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewTitle.isEmpty ? "New" : viewTitle
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 1)
        
        // 保存按钮
        let itemButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(ReadWriteViewContrller.saveDataInfo))
        navigationItem.setRightBarButton(itemButton, animated: false)
        
        // 编辑页面构建
        caption = UITextField(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: 40))
        caption?.backgroundColor = .white
        caption?.leftViewMode = .always
        caption?.adjustsFontSizeToFitWidth = true
        caption?.font = UIFont.boldSystemFont(ofSize: 14)
        caption?.textAlignment = .left
        caption?.placeholder = "Caption"
        let captionLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: 40))
        captionLeftView.text = "Caption"
        captionLeftView.textColor = .gray
        captionLeftView.textAlignment = .center
        caption?.leftView = captionLeftView
        view.addSubview(caption!)
        
        border1 = UILabel.init(frame: CGRect(x: 0, y: 121, width: view.frame.width, height: 1))
        border1?.backgroundColor = UIColor.init(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)
        view.addSubview(border1!)
        
        account = UITextField(frame: CGRect(x: 0, y: 123, width: view.frame.width, height: 40))
        account?.backgroundColor = .white
        account?.leftViewMode = .always
        account?.adjustsFontSizeToFitWidth = true
        account?.font = UIFont.boldSystemFont(ofSize: 14)
        account?.textAlignment = .left
        account?.placeholder = "Account"
        let accountLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: 40))
        accountLeftView.text = "Account"
        accountLeftView.textColor = .gray
        accountLeftView.textAlignment = .center
        account?.leftView = accountLeftView
        view.addSubview(account!)
        
        border2 = UILabel.init(frame: CGRect(x: 0, y: 164, width: view.frame.width, height: 1))
        border2?.backgroundColor = UIColor.init(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)
        view.addSubview(border2!)
        
        password = UITextField(frame: CGRect(x: 0, y: 166, width: view.frame.width, height: 40))
        password?.backgroundColor = .white
        password?.leftViewMode = .always
        password?.adjustsFontSizeToFitWidth = true
        password?.font = UIFont.boldSystemFont(ofSize: 14)
        password?.textAlignment = .left
        password?.placeholder = "Password"
        password?.isSecureTextEntry = true
        let passwordLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: 40))
        passwordLeftView.text = "Password"
        passwordLeftView.textColor = .gray
        passwordLeftView.textAlignment = .center
        password?.leftView = passwordLeftView
        password?.rightViewMode = .always
        let passwordRightView = UIButton.init(frame: CGRect(x: view.frame.width - 40, y: 0, width: 32, height: 40))
        passwordRightView.setImage(UIImage.init(named: "eye_close.png"), for: UIControlState.normal)
        passwordRightView.addTarget(self, action: #selector(passwordRightViewTap(_: )), for: .touchUpInside)
        password?.rightView = passwordRightView
        view.addSubview(password!)
        
        border3 = UILabel.init(frame: CGRect(x: 0, y: 207, width: view.frame.width, height: 1))
        border3?.backgroundColor = UIColor.init(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1)
        view.addSubview(border3!)
        
        let remarkLable = UILabel.init(frame: CGRect(x: 10, y: 209, width: view.frame.width / 4, height: 40))
        remarkLable.text = "Remark:"
        remarkLable.textColor = .gray
        remarkLable.textAlignment = .left
        view.addSubview(remarkLable)
        
        remark = UITextView.init(frame: CGRect(x: 1, y: 249, width: view.frame.width - 2, height: 120))
        remark?.layer.borderWidth = 1
        remark?.layer.borderColor = UIColor.init(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1).cgColor
        remark?.isEditable = true
        remark?.dataDetectorTypes = .all
        view.addSubview(remark!)
    }
    
    // 密码显示与隐藏的控制
    func passwordRightViewTap(_ button: UIButton) {
        let image = (password?.isSecureTextEntry)! ? UIImage.init(named: "eye_open.png") : UIImage.init(named: "eye_close.png")
        button.setImage(image, for: UIControlState.normal)
        password?.isSecureTextEntry = !(password?.isSecureTextEntry)!
    }
    
    // 保存方法
    func saveDataInfo() {
        // 数据监测
        var errorMsg: String = ""
        if caption?.text == nil || (caption?.text?.isEmpty)! {
            errorMsg += "Caption, "
        }
        if account?.text == nil || (account?.text?.isEmpty)! {
            errorMsg += "Account, "
        }
        if password?.text == nil || (password?.text?.isEmpty)! {
            errorMsg += "Password, "
        }
        if !errorMsg.isEmpty {
            errorMsg = errorMsg.subString(start: 0, length: errorMsg.characters.count - 2)
            errorMsg += " can't be empty!"
            
            let emptyAlert = UIAlertController.init(title: nil, message: errorMsg, preferredStyle: .alert)
            present(emptyAlert, animated: true, completion: nil)
            // 2秒后UIAlertController自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return
        }
        
        //TODO 数据存入SQlite
        var info = [ColumnType]()
        let col0 = ColumnType(colName: "dataInfoTableId", colType: nil, colValue: dataInfoKey)
        let col1 = ColumnType(colName: "caption", colType: nil, colValue: caption?.text)
        let col2 = ColumnType(colName: "account", colType: nil, colValue: account?.text)
        let col3 = ColumnType(colName: "password", colType: nil, colValue: password?.text)
        let col4 = ColumnType(colName: "iconName", colType: nil, colValue: "default_icon.png")
        let col5 = ColumnType(colName: "lastEditTime", colType: nil, colValue: NSDate())
        let col6 = ColumnType(colName: "remark", colType: nil, colValue: remark?.text)
        let col7 = ColumnType(colName: "key", colType: nil, colValue: (dataInfoKey?.isEmpty)! ? UUID().uuidString : dataInfoKey)
        // 排序字段先保留，后续再处理
        let col8 = ColumnType(colName: "indexKey", colType: nil, colValue: "0")
        info += [col0, col1, col2, col3, col4, col5, col6, col7, col8]
        //TODO 密码加密
        _ = SQliteRepository.addOrUpdate(tableName: SQliteRepository.PASSWORDINFOTABLE, colValue: info)
        
        navigationController!.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 根据key查询数据，并绑定到控件上
        if dataInfoKey != nil || !(dataInfoKey?.isEmpty)! {
            let sql = "select * from \(SQliteRepository.PASSWORDINFOTABLE) where \(SQliteRepository.PASSWORDINFOTABLE)Id = '\(dataInfoKey!)'"
            let info = SQliteRepository.sqlExcute(sql: sql)
            if info.count > 0 {
                caption?.text = info[info.count - 1]["caption"] as? String
                account?.text = info[info.count - 1]["account"] as? String
                password?.text = info[info.count - 1]["password"] as? String
                remark?.text = info[info.count - 1]["remark"] as? String
                dataInfoKey = info[info.count - 1]["dataInfoTableId"] as? String
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
