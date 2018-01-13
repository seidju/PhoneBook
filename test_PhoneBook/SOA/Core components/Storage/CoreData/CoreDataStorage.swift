//
//  CoreDataStorage.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import CoreData


class CoreDataStorage: StorageProtocol {
 
  
  private var coreDataStack: CoreDataStack!
  var managedContext: NSManagedObjectContext {
    return coreDataStack.managedContext
  }
  init() {
    coreDataStack = CoreDataStack(modelName: "Phonebook")
    subscribeToNotifications()
  }
  
  
  var storageDidChangeContent: (() -> ())?
  
  func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T : Storable {
    //
  }
  
  private func subscribeToNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(forName: Notification.Name.NSManagedObjectContextObjectsDidChange, object: coreDataStack.managedContext, queue: nil) { [weak self] _ in
      self?.storageDidChangeContent?()
    }
  }

  
  func save(object: Storable) throws {
    do {
      try coreDataStack.saveContext()
    } catch {
      throw error
    }
  }
  
  func update(block: (() -> ())? )  {
    do {
      block?()
      try coreDataStack.saveContext()
    } catch {
      print(error)
    }
  }
  
  func delete(object: Storable, completion: (() -> ())?)  {
    delete(objects: [object], completion: completion)
  }

  func delete(objects: [Storable], completion: (() -> ())?)  {
    for object in objects {
      do {
        managedContext.delete(object as! NSManagedObject)
        try coreDataStack.saveContext()
      } catch {
        print(error)
        continue
      }
    }
    completion?()
  }
  
  func fetch<T>(_ model: T.Type, primaryKey: String, completion: ((T) -> ())?) where T : Storable {
    let predicate = NSPredicate(format: "uuid is like $@", primaryKey)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(T.self)")
    fetchRequest.predicate = predicate
    do {
      if let object = try managedContext.fetch(fetchRequest).first as? T {
        completion?(object)
      }
    } catch {
      print("Fetch error: \(error)")
    }
  }
  
  func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: NSSortDescriptor?, completion: (([T]) -> ())?) where T : Storable {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(T.self)")
    fetchRequest.predicate = predicate
    if let sortDescriptor = sorted {
      fetchRequest.sortDescriptors = [sortDescriptor]
    }
    do {
      if let objects = try managedContext.fetch(fetchRequest) as? [T] {
        completion?(objects)
      }
    } catch {
      print("Fetch error: \(error)")
    }
  }
}

extension NSManagedObject: Storable { }
