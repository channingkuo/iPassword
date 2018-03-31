//
//  GlobalAppSetting.swift
//  iPassword
//
//  Created by Channing Kuo on 31/03/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import Foundation

class GlobalAppSetting {
    // 是否完成了最小化动画
    static var isFinishedMinimize: Bool{
        get{
            let v = UserDefaults.standard.value(forKey: "isFinishedMinimize")
            return v == nil ? false : v as! Bool
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isFinishedMinimize")
            UserDefaults.standard.synchronize()
        }
    }
}
