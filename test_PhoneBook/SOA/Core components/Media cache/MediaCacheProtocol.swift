//
//  MediaCacheProtocol.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

protocol MediaCacheProtocol {
  
  func save(key: String, image: UIImage)
  func load(key: String) -> UIImage?
}

