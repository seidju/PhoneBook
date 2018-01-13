//
//  CoordinatorFactoryProtocol.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

protocol CoordinatorFactoryProtocol {
  
  //func makeOnboardingCoordinator(router: Router) -> Coordinator //& OnboardingCoordinatorOutput
  func makeContactsCoordinator(router: Router) -> Coordinator

  
}
