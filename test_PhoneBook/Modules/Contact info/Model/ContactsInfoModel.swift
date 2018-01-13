//
//  ContactsInfoModel.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class ContactsInfoModel {
  private let contact: Contact
  private let contactsService: ContactsServiceProtocol
  private var isEditinig: Bool = false
  let avatarDecorator = CoreFabric().createAvatarDecorator()
  var viewNotificationBlock: ((ContactInfoTableViewController.State) -> ())?

  init(contact: Contact, contactsService: ContactsServiceProtocol) {
    self.contact = contact
    self.contactsService = contactsService
  }
  
  func fillContactInfoForm() {
    if avatarDecorator.loadAvatar(uuid: contact.uuid) == nil {
      let fullname = contact.firstName + " " + contact.lastName
      avatarDecorator.saveAvatar(uuid: contact.uuid, name: fullname)
    }
    viewNotificationBlock?(.initial(contact))

  }
  
  func delete(completion: (() -> ())?) {
    contactsService.delete(contact: contact, completion: completion)
  }
  func update(fullname: String, phoneNumber: String, address1: String?, address2: String?, city: String?, zipCode: String?) {
    let nameComponents = fullname.components(separatedBy: " ")
    var firstName = nameComponents.first ?? ""
    var lastName = nameComponents.last ?? ""
    if nameComponents.count > 0 {
      firstName = nameComponents[0]
      lastName = nameComponents.dropFirst().joined(separator: " ")
    }
    let newContact = Contact(uuid: contact.uuid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, zipCode: zipCode)
    contactsService.update(contact: contact, with: newContact)
  }
  
  func editMode() {
    isEditinig = !isEditinig
    viewNotificationBlock?(.edinitg(isEditinig))
  }
}
