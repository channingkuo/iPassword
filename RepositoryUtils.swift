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
    public func createTable(table: TableStruct<columeType>) -> CInt {
        let tableName = table.tableName
        let primary = table.primaryKey
        var sql = "create table if not exists '\(tableName)'('\(primary)' varchar(100) primary key, "
        for (index, value) in (table.struction?.enumerated())! {
            if index == table.struction?.count {
                sql += "'\(value.name!)' '\(value.type!)', "
            }
            else{
                sql += "'\(value.name!)' '\(value.type!)'"
            }
        }
        return db.execute(sql: sql)
    }
    
    // 存入数据或更新数据
    public func addOrUpdate<T>(data: T) -> CInt {
        
        return 0
    }
    
    // 删除数据（所有数据或删除符合条件的数据）
    public func delete() -> CInt {
        
        return 0
    }
}

class TableStruct<T> {
    var tableName: String?
    var primaryKey: String?
    var struction: [T]?
    
    init(tableName: String, primaryKey: String = "Id", struction: [T]) {
        self.tableName = tableName
        self.primaryKey = primaryKey
        self.struction = struction
    }
}

class columeType {
    var name: String?      // 列名
    var type: String?      // 类型
    
    init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}


