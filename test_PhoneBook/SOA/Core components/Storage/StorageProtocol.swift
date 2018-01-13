//
//  StorageProtocol.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//
import Foundation

protocol StorageProtocol {
  
  var storageDidChangeContent: (() -> ())? { get set }
  
  func save(object: Storable) throws
  func update(block: (() -> ())? ) 

  func delete(object: Storable, completion: (() -> ())?)
  func delete(objects: [Storable], completion: (() -> ())?) 
  func fetch<T: Storable>(_ model: T.Type, primaryKey: String, completion: ((T)->())?)
  func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: NSSortDescriptor?, completion: (([T]) -> ())?)
}

func performBlock(on queue: DispatchQueue, _ block: @escaping ()->()) {
  queue.async {
    autoreleasepool {
      block()
    }
  }
}
