//
//  ContactsService.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class ContactsService: ContactsServiceProtocol {
  
  private var storage: StorageProtocol
  var contactsDidChange: (() -> ())?
  
  init(storage: StorageProtocol) {
    self.storage = storage
    self.storage.storageDidChangeContent = { [weak self] in
      self?.contactsDidChange?()
    }
  }
  
  func showAll(completion: (([Contact]) -> ())?) {
    let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: false)
    storage.fetch(CDContact.self, predicate: nil, sorted: sortDescriptor) { cdContacts in
      let contacts = cdContacts.flatMap { $0.contacts()}
      completion?(contacts)
    }
  }
  
  
  func add(contact: Contact) {
    guard let coreDataStorage = storage as? CoreDataStorage else { return }
    let newCoreDateObject = CDContact(context: coreDataStorage.managedContext)
    newCoreDateObject.uuid = contact.uuid
    newCoreDateObject.firstName = contact.firstName
    newCoreDateObject.lastName = contact.lastName
    newCoreDateObject.phoneNumber = contact.phoneNumber
    newCoreDateObject.address1 = contact.address1
    newCoreDateObject.address2 = contact.address2
    newCoreDateObject.city = contact.city
    newCoreDateObject.zipCode = contact.zipCode
    do {
      try storage.save(object: newCoreDateObject)
    } catch {
      print(error)
    }
  }
  
  func delete(contact: Contact, completion: (() -> ())?) {
    let predicate = NSPredicate(format: "uuid like %@", contact.uuid)
    storage.fetch(CDContact.self, predicate: predicate, sorted: nil) { [weak self] cdContacts in
      guard let contact = cdContacts.first else { return }
      self?.storage.delete(objects: [contact], completion: completion)
    }
  }

  
  func update(contact: Contact, with newContact: Contact) {
    let predicate = NSPredicate(format: "uuid like %@", contact.uuid)
    storage.fetch(CDContact.self, predicate: predicate, sorted: nil) { [weak self] cdContacts in
      guard let contact = cdContacts.first else { return }
      self?.storage.update {
        contact.firstName = newContact.firstName
        contact.lastName = newContact.lastName
        contact.phoneNumber = newContact.phoneNumber
        contact.address1 = newContact.address1
        contact.address2 = newContact.address2
        contact.city = newContact.city
        contact.zipCode = newContact.zipCode
      }
    }
  }
}
