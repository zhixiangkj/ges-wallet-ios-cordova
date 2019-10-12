//
//  GlobalConst.swift
//  ios+cordovaDemo
//
//  Created by 付金亮 on 2018/12/17.
//  Copyright © 2018 付金亮. All rights reserved.
//

import Foundation
//状态栏高度
let STATUS_BAR_HEIGHT = 20
//NavBar高度
let NAVIGATION_BAR_HEIGHT = 44
//状态栏 ＋ 导航栏 高度
let STATUS_AND_NAVIGATION_HEIGHT = STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT

//屏幕 rect
let SCREEN_RECT = UIScreen.main.bounds

let SCREEN_WIDTH = SCREEN_RECT.size.width

let SCREEN_HEIGHT = SCREEN_RECT.size.height

let CONTENT_HEIGHT = (SCREEN_HEIGHT - CGFloat(NAVIGATION_BAR_HEIGHT) - CGFloat(STATUS_BAR_HEIGHT))

// keyWindow
let KEY_WINDOW = UIApplication.shared.keyWindow
// keyWindow to UIView
let KEY_VIEW = KEY_WINDOW as UIView?
class JSON: NSObject {
    // json字符串转字典
    static func parse (dictStr: String) -> [AnyHashable: Any] {
        guard let dict = JSON.parse(dictStr) as? [AnyHashable : Any] else {
            return [:]
        }
        return dict
    }
    // json字符串转数组
    static func parse (arrayStr: String) -> Array<Any> {
        guard let array = JSON.parse(arrayStr) as? Array<Any> else {
            return []
        }
        return array
    }
    // json字符串转任意类型
    static private func parse (_ anyString: String) -> Any {
        let jsonData:Data = anyString.data(using: .utf8)!
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        return json as Any
    }
    // 字典转json字符串
    static func stringify (dict: [AnyHashable: Any]) -> String {
        return JSON.stringify(dict as Any)
    }
    // 数组转json字符串
    static func stringify (array: Array<Any>) -> String {
        return JSON.stringify(array as Any)
    }
    // 任意类型转json字符串
    static private func stringify (_ object: Any) -> String {
        let data = try? JSONSerialization.data(withJSONObject: object, options: []) as NSData
        let JSONString = NSString(data:data! as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
