//
//  NewContactViewController.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

class NewContactViewController: UITableViewController, NewContactView {
  @IBOutlet weak var fullnameTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var address1TextField: UITextField!
  @IBOutlet weak var address2TextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var zipCodeTextField: UITextField!
  
  var onCreateContact: (() -> ())?
  
  var newContactModel: NewContactModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  private func configureUI() {
    title = "New contact"
    
    [phoneTextField, fullnameTextField, address1TextField, address2TextField, cityTextField ,zipCodeTextField].forEach {
      $0?.isUserInteractionEnabled = true
      $0?.delegate = self
    }
    fullnameTextField.placeholder = "Enter fullname"
    phoneTextField.placeholder = "Enter phonenumber"
    address1TextField.placeholder = "Enter main address"
    address2TextField.placeholder = "Enter additional address"
    cityTextField.placeholder = "Enter your city"
    zipCodeTextField.placeholder = "Enter your zip code"
  }
  
  @IBAction func addContact(_ sender: Any) {
    guard let fullname = fullnameTextField.text, let phonenumber = phoneTextField.text else { return }
    guard !fullname.isEmpty else { return }
    newContactModel.add(fullname: fullname, phoneNumber: phonenumber, address1: address1TextField.text, address2: address2TextField.text, city: cityTextField.text, zipcode: zipCodeTextField.text)
    onCreateContact?()
  }
  
 
}

extension NewContactViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

