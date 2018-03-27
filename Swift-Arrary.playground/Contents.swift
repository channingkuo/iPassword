//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"


//class AA{
//    var a: String?
//    var b: String?
//}

var some = [String]()

UUID().uuidString
UUID()

let now = NSDate()
let yestoday_now = NSDate(timeInterval: -24 * 60 * 60, since: now as Date)

let interval1 = now.timeIntervalSince(yestoday_now as Date)
print(interval1 / 24.0)
