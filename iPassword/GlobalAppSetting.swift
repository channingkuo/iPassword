//
//  GlobalAppSetting.swift
//  iPassword
//
//  Created by Channing Kuo on 31/03/2018.
//  Copyright © 2018 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit

class GlobalAppSetting {
    // 最小化view的高度（区别iPhone X）
    static var minimizeViewHeight: CGFloat {
        get{
            if UIDevice().deviceName == "iPhone X" || (UIDevice().deviceName == "Simulator" && UIDevice().systemVersion == "11.3") {
                return 60
            }
            return 50
        }
    }
}
