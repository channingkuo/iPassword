//
//  RepositoryUtils.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/23.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import Foundation

class Repository {
    
    private var db: SQLiteDB!
    
    init() {
        db = SQLiteDB.sharedInstance
    }
    
    // 创建表
//    public func createTable1(table: TableStruct<ColumeType>) -> CInt {
//        let tableName = table.tableName
//        let primary = table.primaryKey
//        var sql = "create table if not exists '\(tableName)'('\(primary)' varchar(100) primary key, "
//        for (index, value) in (table.struction?.enumerated())! {
//            if index == table.struction?.count {
//                sql += "'\(value.name!)' '\(value.type!)' "
//            }
//            else{
//                sql += "'\(value.name!)' '\(value.type!)',"
//            }
//        }
//        return db.execute(sql: sql)
//    }
    
    // 创建表
    public func createTable<T: NSObject>(data: T) -> CInt {
        // 获取 T 中的所有属性的名称
        let propertyName = data.propertyNames()
        // 表名
        let tableName = data.value(forKey: "tableName")
        
        var sql = "create table if not exists '\(tableName)'("
//        if let primaryKey = data.value(forKey: "primaryKey") {
//            sql += " '\(primaryKey)' varchar(100) primary key, "
//        }
//        else{
            // 默认的primary key为 表名 + Id
            sql += " '\(tableName!)'Id varchar(100) primary key, "
//        }
        
        for (index, value) in propertyName.enumerated() {
            if value == "tableName" || value == "primaryKey" {
                continue
            }
            if index != propertyName.count {
                sql += " '\(value)' '\(data.value(forKey: value)!)', "
            }
            else{
                sql += " '\(value)' '\(data.value(forKey: value)!)') "
            }
        }
        return db.execute(sql: sql)
    }
    
    // 存入数据
    public func syncInsert<T: NSObject>(data: [T]) -> CInt {
        
        return 0
    }
    
    // 插入数据或更新数据
    public func addOrUpdate<T: NSObject>(data: T) -> CInt {
        let propertyName = data.propertyNames()
        let tableName = data.value(forKey: "tableName")
        let primaryKey = data.value(forKey: "primaryKey")
        let id = checkExist(tableName: tableName as! String, key: primaryKey as! String)
        if id.isEmpty {
            // Update
            // update '\(tableName!)' set 列名 = 值, 列名 = 值....
            var sqlUpdate = "update '\(tableName!)' set "
            for (index, value) in propertyName.enumerated() {
                if index != propertyName.count {
                    sqlUpdate += " '\(value)' = '\(data.value(forKey: value)!)', "
                }
                else{
                    sqlUpdate += " '\(value)' = '\(data.value(forKey: value)!)' "
                }
            }
            // 添加更新条件
            return db.execute(sql: sqlUpdate)
        }
        else{
            // Add
            // insert into t_user(uname,mobile) values('\(uname)','\(mobile)')
            var sqlAdd = "insert into '\(tableName!)'("
            for value in propertyName {
                sqlAdd += " '\(value)', "
            }
            sqlAdd = sqlAdd.subString(start: 0, length: sqlAdd.characters.count - 1) + ") values("
            for value in propertyName {
                sqlAdd += " '\(data.value(forKey: value)!)', "
            }
            sqlAdd = sqlAdd.subString(start: 0, length: sqlAdd.characters.count - 1) + ")"
            return db.execute(sql: sqlAdd)
        }
    }
    
    // 删除数据（所有数据或删除符合条件的数据）
    public func delete() -> CInt {
        
        return 0
    }
    
    private func checkExist(tableName: String, key: String) -> String {
        let sql = "select top 1 '\(tableName)'Id from '\(tableName)' where '\(tableName)'Id = '\(key)'"
        let data = db.query(sql: sql)
        if(data.count > 0){
            let info = data[data.count - 1]
            return (info["'\(tableName)'Id"] as! String)
        }
        return ""
    }
}

struct TableStruction {
    var table: String
}

class TableStruct<T>: NSObject {
    var tableName: String?
    var primaryKey: String?
    var struction: [T]?
    
    init(tableName: String, primaryKey: String = "Id", struction: [T]) {
        self.tableName = tableName
        self.primaryKey = primaryKey
        self.struction = struction
    }
}

class ColumeType: NSObject {
    var name: String?      // 列名
    var type: String?      // 类型
    
    init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}

extension NSObject {
    
    // Retrieves an array of property names found on the current object
    func propertyNames() -> [String] {
        var results = [String]()
        
        // retrieve the properties via the class_copyPropertyList function
        var count: UInt32 = 0
        let myClass: AnyClass = self.classForCoder
        let properties = class_copyPropertyList(myClass, &count)
        
        // iterate each objc_property_t struct
        for i in 0 ..< count {
            let property = properties?[Int(i)]
            let cname = property_getName(property)
            //convert the c string into a Swift string
            let name = String.init(cString: cname!, encoding: String.Encoding.utf8)
            results.append(name!)
        }
        return results
    }
}


