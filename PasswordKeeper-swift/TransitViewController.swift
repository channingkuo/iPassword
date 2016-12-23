//
//  ViewController.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/19.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import UIKit

class TransitViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.71)
        
        
//        let example: Array<columeType> = [columeType(name: "aaa", type: "integer"), columeType(name: "bbb", type: "integer")]
//        let tableStructEmample = TableStruct<columeType>(tableName: "table1", primaryKey: "Id", struction: example)
//        print(tableStructEmample.tableName)
//        print(tableStructEmample.primaryKey)
//        print(tableStructEmample.struction?[0].name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

