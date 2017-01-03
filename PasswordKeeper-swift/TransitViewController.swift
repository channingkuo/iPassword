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
        
//        var a: Repository
//        a = Repository()
//        let aa = ColumeType(name: "ttt", type: "yyyy")
//        var b = a.create(data: aa)
        
//        let aa = ColumeType(name: "9", type: "9")
//        var aaa = aa.propertyNames()
//        let aaaaa = aa.value(forKey: "name")
//        print(aaaaa!)
        var oo = [ColumnType]()
        let o1 = ColumnType(colName: "test1", colType: "varchar(100)", colValue: "1")
        let o2 = ColumnType(colName: "test2", colType: "varchar(100)", colValue: "2")
        let o3 = ColumnType(colName: "test3", colType: "varchar(100)", colValue: "3")
        oo += [o1, o2, o3]
        //SQliteRepository.createTable(tableName: "test", columns: oo)
        //let p = SQliteRepository.addOrUpdate(tableName: "test", colValue: oo)
        //print(p)
        let pp = SQliteRepository.getData(tableName: "test")
        print(pp)
//        var ii = [ColumnType]()
//        let o11 = ColumnType(colName: "testId", colType: nil, colValue: "D0C214FD-36B1-4F2A-9D2D-2DA45FED4768")
//        ii += [o11]
//        let i = SQliteRepository.delete(tableName: "test", columns: ii)
//        print(i)
        let iu = SQliteRepository.deleteAll(tableName: "test")
        print(iu)
        let ppp = SQliteRepository.getData(tableName: "test")
        print(ppp)
    }
    //value	String	"D0C214FD-36B1-4F2A-9D2D-2DA45FED4768"
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

