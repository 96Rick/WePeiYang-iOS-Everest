//
//  TwTUser.swift
//  WePeiYang
//
//  Created by Halcao on 2017/7/14.
//  Copyright © 2017年 twtstudio. All rights reserved.
//

import UIKit

let suiteName = "group.WePeiYang"

class TwTUser: NSObject {
    static let shared = TwTUser()
    private override init() {}
    var token: String?
    var username: String = ""
    var libraryState: Bool = false
    var schoolID: String = ""
    var tjuBindingState: Bool = false
    
    func save() {
        var dic: [String: Any] = [:]
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(TwTUser.self, &outCount)
        for i in 0..<outCount {
            if let ivar = ivars?[Int(i)],
                let cName = ivar_getName(ivar),
                let name = String(cString: cName, encoding: String.Encoding.utf8), let obj = self.value(forKey: name) {
                // save non-nil property
                dic[name] = obj
            }
        }
        let dict = NSDictionary(dictionary: dic)
        UserDefaults(suiteName: suiteName)?.set(dict, forKey: "TwTUser")
    }
    
    func delete() {
        UserDefaults(suiteName: suiteName)?.removeObject(forKey: "TwTUser")
    }
    
    func load() {
        if let dict = UserDefaults(suiteName: suiteName)?.object(forKey: "TwTUser") as? NSDictionary {
            var outCount: UInt32 = 0
            let ivars = class_copyIvarList(TwTUser.self, &outCount)
            for i in 0..<outCount {
                if let ivar = ivars?[Int(i)],
                    let cName = ivar_getName(ivar),
                    let name = String(cString: cName, encoding: String.Encoding.utf8), let value = dict[name] {
                    // save non-nil property
                    self.setValue(value, forKey: name)
                }
            }
        }
    }
}
