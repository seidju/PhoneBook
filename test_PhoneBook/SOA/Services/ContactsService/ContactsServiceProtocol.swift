//
//  ContactsServiceProtocol.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol ContactsServiceProtocol {
  
  var contactsDidChange: (() -> ())? { get set }
  func showAll(completion: ( ([Contact]) -> () )?)
  func add(contact: Contact)
  func update(contact: Contact, with newContact: Contact)
  func delete(contact: Contact, completion: (() -> ())?)
}
