//
//  RealmStorage.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import RealmSwift

class RealmStorage: StorageProtocol {
  var storageDidChangeContent: (() -> ())?
  
  private var notificationToken: NotificationToken?
  
  deinit {
    notificationToken?.invalidate()
  }
  
  func update(block: (() -> ())?) {
    let realm = try! Realm()
    try! realm.write {
      block?()
    }
  }

    func save(object: Storable) throws {
    do {
      let realm = try Realm()
      realm.add(object as! Object, update: true)
    } catch {
      throw error
    }
  }
  
  func delete(objects: [Storable], completion: (() -> ())?)  {
    let realm = try! Realm()
    realm.delete(objects as! [Object])
  }
  
  func delete(object: Storable, completion: (() -> ())?)  {
    delete(objects: [object], completion: completion)
  }
  
  func fetch<T>(_ model: T.Type, primaryKey: String, completion: ((T) -> ())?) where T : Storable {
    let realm = try! Realm()
    if let object = realm.object(ofType: model as! Object.Type, forPrimaryKey: primaryKey) as? T {
      completion?(object)
    }
  }
  
  func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: NSSortDescriptor?, completion: (([T]) -> ())?) where T : Storable {
    //
  }
}


extension Object: Storable {}
