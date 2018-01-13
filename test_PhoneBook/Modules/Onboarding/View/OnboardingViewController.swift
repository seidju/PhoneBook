//
//  OnboardingViewController.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

class OnboardingViewControler: UIPageViewController, OnboardingView {
  
  var onFinish: (() -> Void)?
  var pages = [UIViewController]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populateVC()
    dataSource = self
    if let firstViewController = pages.first {
      setViewControllers([firstViewController],
                         direction: .forward,
                         animated: true,
                         completion: nil)
    }
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  private func populateVC() {
    let onboarding = UIStoryboard(name: Storyboards.onboarding.rawValue, bundle: nil)
    let page1 = onboarding.instantiateViewController(withIdentifier: "OnboardingPageOne") as! OnboardingPage
    let page2 = onboarding.instantiateViewController(withIdentifier: "OnboardingPageTwo") as! OnboardingPage
    let page3 = onboarding.instantiateViewController(withIdentifier: "OnboardingPageThree") as! OnboardingPage
    page3.finishOnboarding = { [weak self] in
      self?.onFinish?()
    }
    pages.append(contentsOf: [page1,page2, page3])
    
  }
  
}
extension OnboardingViewControler: UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = pages.index(of: viewController) else {
      return nil
    }
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = pages.count
    guard orderedViewControllersCount != nextIndex else {
      return nil
    }
    guard orderedViewControllersCount > nextIndex else {
      return nil
    }
    return pages[nextIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = pages.index(of: viewController) else {
      return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    guard previousIndex >= 0 else {
      return nil
    }
    guard pages.count > previousIndex else {
      return nil
    }
    return pages[previousIndex]
  }
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return pages.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = pages.index(of:firstViewController) else {
      return 0
    }
    return firstViewControllerIndex
  }
  
}

class OnboardingPage: UIViewController {
  var finishOnboarding:(() -> ())?
  @IBAction func finish(_ sender: Any) {
    finishOnboarding?()
  }
  
}


