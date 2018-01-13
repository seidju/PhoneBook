//
//  CoreFabric.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class CoreFabric {
  
  func createRealmStorage() -> StorageProtocol {
    return RealmStorage()
  }
  
  func createCoreDataStorage() -> StorageProtocol {
    return CoreDataStorage()
  }

  func createAvatarDecorator() -> AvatarDecoratorProtocol {
    return AvatarDecorator()
  }
  
}

