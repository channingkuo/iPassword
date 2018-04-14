//
//  SQLiteUtils.swift
//  iPassword
//
//  Created by Channing Kuo on 2018/4/14.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import Foundation
import SQLite

class SQLiteUtils {
    
    private static let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    public static let db = try! Connection("\(SQLiteUtils.path)/db.sqlite3")
    public static let table = Table("password")
    public static let title = Expression<String>("title")
    public static let account = Expression<String>("account")
    public static let password = Expression<String>("password")
    public static let icon = Expression<String>("icon")
    public static let modifytime = Expression<String>("modifytime")
    public static let remark = Expression<String>("remark")
    public static let index = Expression<Int64>("index")
    public static let id = Expression<String>("id")
    
    class func initTable() {
        try! self.db.run(self.table.create(ifNotExists: true, block: { t in
            t.column(self.title)
            t.column(self.account)
            t.column(self.password)
            t.column(self.icon)
            t.column(self.modifytime)
            t.column(self.remark)
            t.column(self.index, unique: true)
            t.column(self.id, primaryKey: true)
        }))
    }
}
