//
//  CoordinatorFactory.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryProtocol {
  
  func makeContactsCoordinator(router: Router) -> Coordinator {
    let contactCoordinator = ContactsCoordinator(router: router, moduleFactory: ModuleFactory())
    return contactCoordinator
  }
  func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput {
    let onboardingCoordinator = OnboardingCoordinator(with: ModuleFactory(), router: router)
    return onboardingCoordinator
  }
  
}
