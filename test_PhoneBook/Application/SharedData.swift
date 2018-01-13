//
//  SharedData.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class SharedData {
  
  static let shared = SharedData()
  
  let storageQueue = DispatchQueue(label: "storage")
  
  var firstStart: Bool {
    if let _ = getFromSettings(key: "firstStart") as? Bool {
      return false
    }
    return true
  }
}

func getFromSettings(key: String) -> AnyObject? {
  let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
  return UserDefaults.standard.object(forKey: "\(appName).\(key)") as AnyObject?
}

//Set settings to user defaults
func setToSettings(key: String, value: AnyObject) {
  let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
  UserDefaults.standard.set(value, forKey: "\(appName).\(key)")
  UserDefaults.standard.synchronize()
}
