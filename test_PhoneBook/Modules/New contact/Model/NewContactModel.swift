//
//  NewContactModel.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class NewContactModel {
  private let contactsService: ContactsServiceProtocol
  
  init(contactsService: ContactsServiceProtocol) {
    self.contactsService = contactsService
  }
  
  func add(fullname: String, phoneNumber: String, address1: String?, address2: String?, city: String?, zipcode: String?) {
    let nameComponents = fullname.components(separatedBy: " ")
    var firstName = nameComponents.first ?? ""
    var lastName = nameComponents.last ?? ""
    if nameComponents.count > 0 {
      firstName = nameComponents[0]
      lastName = nameComponents.dropFirst().joined(separator: " ")
    }
    let newContact = Contact(uuid: UUID().uuidString, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, zipCode: zipcode)
    contactsService.add(contact: newContact)
  }
}
