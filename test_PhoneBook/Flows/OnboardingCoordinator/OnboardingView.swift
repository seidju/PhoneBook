//
//  OnboardingView.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

protocol OnboardingView: BaseView {
  var onFinish: (() -> Void)? { get set }
}
