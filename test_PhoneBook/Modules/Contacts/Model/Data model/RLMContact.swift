//
//  RLMContact.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import RealmSwift


class RLMContact: Object {
  
  @objc dynamic var uuid: String = ""
  @objc dynamic var firstName: String = ""
  @objc dynamic var lastName: String = ""
  @objc dynamic var phonenumber: String = ""
  
}

