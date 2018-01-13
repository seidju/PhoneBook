//
//  ContactsModuleFactoryProtocol.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

protocol ContactsModuleFactoryProtocol {
  
  func createContactsOutput() -> ContactsView
  func createContactInfoOutput(contact: Contact) -> ContactInfoView
  func createNewContactOutput() -> NewContactView 

}
