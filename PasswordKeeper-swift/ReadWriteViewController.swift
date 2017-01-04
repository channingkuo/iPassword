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
    let dataInfoKey: String?
    
    var border1, border2, border3: UILabel?
    var caption, account, password: UITextField?
    
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
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.71)
        
        // 编辑页面构建
        caption = UITextField(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 40))
        caption?.backgroundColor = UIColor.white
        caption?.leftViewMode = UITextFieldViewMode.always
        caption?.adjustsFontSizeToFitWidth = true
        caption?.font = UIFont.boldSystemFont(ofSize: 16)
        caption?.textAlignment = NSTextAlignment.left
        caption?.placeholder = "Caption"
        let captionLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: 40))
        captionLeftView.text = "Caption"
        captionLeftView.textColor = UIColor.gray
        captionLeftView.textAlignment = NSTextAlignment.center
        caption?.leftView = captionLeftView
        
        border1 = UILabel.init(frame: CGRect(x: 0, y: 50, width: (caption?.frame.width)!, height: 1))
        border1?.backgroundColor = UIColor.init(red: 240, green: 240, blue: 240, alpha: 0)
        
        account = UITextField(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 40))
        account?.backgroundColor = UIColor.white
        account?.leftViewMode = UITextFieldViewMode.always
        account?.adjustsFontSizeToFitWidth = true
        account?.font = UIFont.boldSystemFont(ofSize: 16)
        account?.textAlignment = NSTextAlignment.left
        account?.placeholder = "Account"
        let accountLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: 40))
        accountLeftView.text = "Account"
        accountLeftView.textColor = UIColor.gray
        accountLeftView.textAlignment = NSTextAlignment.center
        account?.leftView = accountLeftView
        
        border2 = UILabel.init(frame: CGRect(x: 0, y: 100, width: (account?.frame.width)!, height: 1))
        border2?.backgroundColor = UIColor.init(red: 240, green: 240, blue: 240, alpha: 0)
        
        password = UITextField(frame: CGRect(x: 0, y: 110, width: view.frame.width, height: 40))
        password?.backgroundColor = UIColor.white
        password?.leftViewMode = UITextFieldViewMode.always
        password?.adjustsFontSizeToFitWidth = true
        password?.font = UIFont.boldSystemFont(ofSize: 16)
        password?.textAlignment = NSTextAlignment.left
        password?.placeholder = "Password"
        let passwordLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 4, height: 40))
        passwordLeftView.text = "Password"
        passwordLeftView.textColor = UIColor.gray
        passwordLeftView.textAlignment = NSTextAlignment.center
        password?.leftView = accountLeftView
        password?.rightView = UITextFieldViewMode.always
        let passwordRightView = UIButton.init(frame: CGRect(x: view.frame.width - 40, y: 0, width: 32, height: 40))
        password?.rightView = passwordRightView
        
        border3 = UILabel.init(frame: CGRect(x: 0, y: 150, width: (account?.frame.width)!, height: 1))
        border3?.backgroundColor = UIColor.init(red: 240, green: 240, blue: 240, alpha: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 根据key查询数据，并绑定到控件上
        if dataInfoKey != nil || !(dataInfoKey?.isEmpty)! {
            let sql = "select * from \(SQliteRepository.PASSWORDINFOTABLE) where \(SQliteRepository.PASSWORDINFOTABLE)Id = '\(dataInfoKey)'"
            let info = SQliteRepository.sqlExcute(sql: sql)
            if info.count > 0 {
                caption?.text = info[info.count - 1]["caption"] as? String
                account?.text = info[info.count - 1]["account"] as? String
                password?.text = info[info.count - 1]["password"] as? String
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
