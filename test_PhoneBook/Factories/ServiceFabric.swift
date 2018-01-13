//
//  ServiceFabric.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class ServiceFabric {
  private let storage = CoreFabric().createCoreDataStorage()
  func createContactsService() -> ContactsServiceProtocol {
    return ContactsService(storage: storage)
  }
}
