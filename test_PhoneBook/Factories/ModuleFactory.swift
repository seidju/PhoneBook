//
//  ModuleFactory.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class ModuleFactory: ContactsModuleFactoryProtocol {
  
  private let contactsService = ServiceFabric().createContactsService()
  
  func createContactsOutput() -> ContactsView {
    let contactsVc = ContactsViewController.controllerFromStoryboard(.main)
    let contactsModel = ContactsModel(contactsService: contactsService)
    contactsVc.contactsModel = contactsModel
    return contactsVc
  }
  
  func createContactInfoOutput(contact: Contact) -> ContactInfoView {
    let contactInfoVc = ContactInfoTableViewController.controllerFromStoryboard(.main)
    let contactInfoModel = ContactsInfoModel(contact: contact, contactsService: contactsService)
    contactInfoVc.contactInfoModel = contactInfoModel
    return contactInfoVc
  }
  
  func createNewContactOutput() -> NewContactView {
    let newContactVc = NewContactViewController.controllerFromStoryboard(.main)
    let newContactModel = NewContactModel(contactsService: contactsService)
    newContactVc.newContactModel = newContactModel
    return newContactVc
  }
  
}
