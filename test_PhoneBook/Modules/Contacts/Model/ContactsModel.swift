//
//  ContactsModel.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import SwiftyJSON


class ContactsModel {
  
  private var contactsService: ContactsServiceProtocol
  var viewNotificationBlock: ((ContactsViewController.State) -> ())?

  
  init(contactsService: ContactsServiceProtocol) {
    self.contactsService = contactsService
    self.contactsService.contactsDidChange = { [weak self] in
      self?.fetchAllContacts()
    }
  }
  
  
  func fetchAllContacts() {
    contactsService.showAll { [weak self] contacts in
      var initialsDict = [String: [Contact]]()
      for contact in contacts {
        var letter = "#"
        if !contact.lastName.isEmpty { letter = String(contact.lastName.first!) }
        else if contact.lastName.isEmpty && !contact.firstName.isEmpty { letter = String(contact.firstName.first!) }
        if let _ = initialsDict[letter] {
          initialsDict[letter]!.append(contact)
        } else {
          let newArray = [contact]
          initialsDict[letter] = newArray
        }
      }
      self?.viewNotificationBlock?(.showContacts(initialsDict))
    }
  }
  
  func fetchInitialDataFromJSON() {
    guard getFromSettings(key: "firstStart") as? Bool == nil else { return }
    guard let filePath = Bundle.main.path(forResource: "contacts", ofType: "json") else { return }
    let url = URL(fileURLWithPath: filePath)
    do {
      let data = try Data(contentsOf: url)
      let json = try JSON(data: data)
      guard let jsonContacts = json["contacts"].array else { return }
      var contacts = [Contact]()
      for json in jsonContacts {
        guard let uuid = json["uuid"].string else { continue }
        guard let firstName = json["firstName"].string else { continue }
        guard let lastName = json["lastName"].string else { continue }
        guard let phoneNumber = json["phoneNumber"].string else { continue }
        let address1 = json["address1"].string
        let address2 = json["address2"].string
        let city = json["city"].string
        let zipcode = json["zipcode"].string

        let contact = Contact(uuid: uuid, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, address1: address1, address2: address2, city: city, zipCode: zipcode)
        contacts.append(contact)
      }
      saveToDb(contacts: contacts)
      setToSettings(key: "firstStart", value: false as AnyObject)
    } catch {
      print(error)
    }
  }
  
  
  private func saveToDb(contacts: [Contact]) {
    for contact in contacts {
      contactsService.add(contact: contact)
    }
    fetchAllContacts()
  }
  
  
}
