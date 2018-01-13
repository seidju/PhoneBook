//
//  UIScrollViewExtenstions.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

extension UIScrollView {
  func setContentInsetAdjustment(enabled: Bool, in viewController: UIViewController) {
    #if swift(>=3.2)
      if #available(iOS 11.0, *) {
        self.contentInsetAdjustmentBehavior = enabled ? .always : .never
      } else {
        viewController.automaticallyAdjustsScrollViewInsets = enabled
      }
    #else
      viewController.automaticallyAdjustsScrollViewInsets = enabled
    #endif
  }
}
