//
//  AppDelegate.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var rootController: UINavigationController {
    return self.window!.rootViewController as! UINavigationController
  }
  private lazy var applicationCoordinator: Coordinator = makeCoordinator()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let notification = launchOptions?[.remoteNotification] as? [String: AnyObject]
    let deepLink = DeepLinkOption.build(with: notification)
    applicationCoordinator.start(with: deepLink)
    //applicationCoordinator.start()
    
    return true
  }
  
  private func makeCoordinator() -> Coordinator {
    return ApplicationCoordinator( router: RouterImp(rootController: rootController), coordinatorFactory: CoordinatorFactory())
  }

}

