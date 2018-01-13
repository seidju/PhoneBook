//
//  OnboardingCoordinator.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {
  
  var finishFlow: (() -> ())?
  
  private let factory: OnboardingModuleFactoryProtocol
  private let router: Router
  
  init(with factory: OnboardingModuleFactoryProtocol, router: Router) {
    self.factory = factory
    self.router = router
  }
  
  override func start() {
    showOnboarding()
  }
  
  func showOnboarding() {
    let onboardingModule = factory.createOnboardingOutput()
    onboardingModule.onFinish = { [weak self] in
      self?.finishFlow?()
    }
    router.setRootModule(onboardingModule)
  }
}
