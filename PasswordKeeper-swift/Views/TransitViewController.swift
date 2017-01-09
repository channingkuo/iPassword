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
        
        //TODO 验证TouchID
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.init(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.71)
        
        // 初始化数据表
        var dataInfoTable = [ColumnType]()
        let col1 = ColumnType(colName: "caption", colType: "varchar(100)", colValue: nil)
        let col2 = ColumnType(colName: "account", colType: "varchar(100)", colValue: nil)
        let col3 = ColumnType(colName: "password", colType: "varchar(100)", colValue: nil)
        let col4 = ColumnType(colName: "iconName", colType: "varchar(100)", colValue: nil)
        let col5 = ColumnType(colName: "lastEditTime", colType: "datetime", colValue: nil)
        let col6 = ColumnType(colName: "remark", colType: "varchar(200)", colValue: nil)
        let col7 = ColumnType(colName: "key", colType: "varchar(100) not null", colValue: nil)
        let col8 = ColumnType(colName: "indexKey", colType: "int not null", colValue: nil)
        dataInfoTable += [col1, col2, col3, col4, col5, col6, col7, col8]
        SQliteRepository.createTable(tableName: SQliteRepository.PASSWORDINFOTABLE, columns: dataInfoTable)
        
//        var oo = [ColumnType]()
//        let o1 = ColumnType(colName: "test1", colType: "varchar(100)", colValue: "1")
//        let o2 = ColumnType(colName: "test2", colType: "varchar(100)", colValue: "2")
//        let o3 = ColumnType(colName: "test3", colType: "varchar(100)", colValue: "3")
//        oo += [o1, o2, o3]
//        SQliteRepository.createTable(tableName: "test", columns: oo)
//        let p = SQliteRepository.addOrUpdate(tableName: "test", colValue: oo)
//        print(p)
//        let pp = SQliteRepository.getData(tableName: "test")
//        print(pp)
//        var ii = [ColumnType]()
//        let o11 = ColumnType(colName: "testId", colType: nil, colValue: "D0C214FD-36B1-4F2A-9D2D-2DA45FED4768")
//        ii += [o11]
//        let i = SQliteRepository.delete(tableName: "test", columns: ii)
//        print(i)
//        let iu = SQliteRepository.deleteAll(tableName: "test")
//        print(iu)
//        let ppp = SQliteRepository.getData(tableName: "test")
//        print(ppp)
        //private var _index: Int?
        //public var index: Int? {
        //get{
        //    return self._index
        //}
        //set(value){
        //    self._index = value
        //}
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

