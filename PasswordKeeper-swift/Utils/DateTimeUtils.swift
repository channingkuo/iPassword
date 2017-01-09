//
//  DateTimeUtils.swift
//  PasswordKeeper-swift
//
//  Created by Channing on 2017/1/5.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation

class DateTimeUtils {
    
    // 把NSDate时间转换成昨天、前天、星期几、等格式
    static func dateTimeFormatter(dateTime: NSDate, isShowTime: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let now = NSDate()
        let date = dateFormatter.string(from: dateTime as Date)
        let yestoday_now = NSDate(timeInterval: -24 * 60 * 60, since: now as Date)
        let yestoday_yestoday_now = NSDate(timeInterval: -24 * 60 * 60, since: yestoday_now as Date)
        let now_date = dateFormatter.string(from: now as Date)
        if date == now_date {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: dateTime as Date)
        }
        else if date == dateFormatter.string(from: yestoday_now as Date) {
            dateFormatter.dateFormat = "HH:mm"
            return "昨天" + (isShowTime ? " " + dateFormatter.string(from: dateTime as Date) : "")
        }
        else if date == dateFormatter.string(from: yestoday_yestoday_now as Date) {
            dateFormatter.dateFormat = "HH:mm"
            return "前天" + (isShowTime ? " " + dateFormatter.string(from: dateTime as Date) : "")
        }
        else if now.timeIntervalSince(dateTime as Date) < 7 * 24 {
            return dateTime.dayOfWeek() + (isShowTime ? " " + dateFormatter.string(from: dateTime as Date) : "")
        }
        else {
            dateFormatter.dateFormat = "HH:mm"
            return date + (isShowTime ? " " + dateFormatter.string(from: dateTime as Date) : "")
        }
    }
}

