//
//  MediaCache.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Cache

class MediaCache: MediaCacheProtocol {
  
  static let shared = MediaCache()
  
  private let diskConfig = DiskConfig(
    name: "TestCache",
    expiry: .never,
    maxSize: 0,
    directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                            appropriateFor: nil, create: true).appendingPathComponent("MyPreferences"),
    protectionType: .complete
  )
  
  private var storage: Storage!
  
  init() {
    do {
      storage = try Storage(diskConfig: diskConfig)
    } catch {
      print(error)
      fatalError()
    }
  }

  
  func save(key: String, image: UIImage) {
    let wrapper = ImageWrapper(image: image)
    try! storage?.setObject(wrapper, forKey: key)
    
  }
  
  func load(key: String) -> UIImage? {
    let image = try? storage.object(ofType: ImageWrapper.self, forKey: key)
    return image?.image
  }
}

