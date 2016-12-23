//
//  DataInfoModel.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2016/12/20.
//  Copyright © 2016年 Channing Kuo. All rights reserved.
//

import Foundation

// 数据存储对象
class DataInfoModel{
    // 标题
    var caption: String?
    // 账号
    var account: String?
    // 密码(自己用在考虑要不要加密，MD5，BASE64，AES等)
    var password: String?
    // iconName
    var iconName: String?
    // 最后编辑时间
    var lastEditTime: NSDate?
    // key(guid/uuid)
    var key: String
    // 排序字段
    private var _index: Int?
    public var index: Int? {
        get{
            return self._index
        }
        set(value){
            self._index = value
        }
    }
    
    init(key: String) {
        self.key = key
    }
}
