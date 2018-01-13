//
//  AvatarDecoratorProtocol.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

protocol AvatarDecoratorProtocol {
  func saveAvatar(uuid: String, name: String)
  func loadAvatar(uuid: String) -> UIImage?
}
