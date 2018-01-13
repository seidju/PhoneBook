//
//  Contacts.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

struct Contact {
  let uuid: String
  let firstName: String
  let lastName: String
  let phoneNumber: String
  let address1: String?
  let address2: String?
  let city: String?
  let zipCode: String?
}


extension CDContact {
  func contacts() -> Contact? {
    guard let uuid = self.uuid, let firstName = self.firstName, let lastName = self.lastName, let phoneNumber = self.phoneNumber else { return nil }
    
    return Contact(uuid: uuid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, zipCode: zipCode)
  }
}
