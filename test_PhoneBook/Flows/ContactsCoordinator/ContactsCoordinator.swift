//
//  ContactsCoordinator.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

final class ContactsCoordinator: BaseCoordinator {
  
  private let contactsModuleFactory: ContactsModuleFactoryProtocol
  private let router: Router

  init(router: Router, moduleFactory: ContactsModuleFactoryProtocol) {
    self.router = router
    self.contactsModuleFactory = moduleFactory
  }
  
  override func start() {
    showContacts()
  }
  
  func showContacts() {
    let contactsVc = contactsModuleFactory.createContactsOutput()
    contactsVc.didSelectContact = {[weak self] contact in
      self?.showContactInfo(contact: contact)
    }
    contactsVc.didSelectNewContact = { [weak self] in
      self?.showNewContact()
    }
    router.push(contactsVc)
  }
  
  func showContactInfo(contact: Contact) {
    let contactInfoVc = contactsModuleFactory.createContactInfoOutput(contact: contact)
    contactInfoVc.onDeleteContact = { [weak self] in
      self?.router.popModule()
    }
    router.push(contactInfoVc)
  }
  
  func showNewContact() {
    let newContactVc = contactsModuleFactory.createNewContactOutput()
    newContactVc.onCreateContact = { [weak self] in
      self?.router.popModule()
    }
    router.push(newContactVc)
  }
  
}
