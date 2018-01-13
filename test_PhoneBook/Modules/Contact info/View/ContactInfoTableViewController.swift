//
//  ContactInfoViewController.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit

class ContactInfoTableViewController: UITableViewController, ContactInfoView {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var fullnameTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  @IBOutlet weak var address1TextField: UITextField!
  @IBOutlet weak var address2TextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var zipCodeTextField: UITextField!

  
  var onDeleteContact: (() -> ())?
  
  var contactInfoModel: ContactsInfoModel!
    
  enum State {
    case initial(Contact)
    case edinitg(Bool)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    contactInfoModel.viewNotificationBlock = {[weak self] state in
      self?.renderUI(state: state)
    }
    contactInfoModel.fillContactInfoForm()
  }
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    guard let header = tableView.tableHeaderView else { return }
    avatarImageView.layer.cornerRadius = header.bounds.height / 2
    avatarImageView.clipsToBounds = true
  }
  
  private func configureUI() {
    let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction(sender:)))
    navigationItem.setRightBarButton(editButton, animated: true)
    setEditMode(enable: false)
    
    [phoneTextField, fullnameTextField, address1TextField, address2TextField, cityTextField ,zipCodeTextField].forEach {
      $0.delegate = self
    }
  }
  
  private func renderUI(state: State) {
    switch state {
      case .initial(let contact):
        fillContactForms(contact: contact)
      case .edinitg(let isEditing):
        setEditMode(enable: isEditing)
    }
  }

  private func fillContactForms(contact: Contact) {
    let fullname =  contact.firstName + " " + contact.lastName
    self.title = fullname
    fullnameTextField.text = fullname
    phoneTextField.text = contact.phoneNumber
    address1TextField.text = contact.address1
    address2TextField.text = contact.address2
    cityTextField.text = contact.city
    zipCodeTextField.text = contact.zipCode
    avatarImageView.image = contactInfoModel.avatarDecorator.loadAvatar(uuid: contact.uuid)
  }
  
  
  private func setEditMode(enable: Bool) {
    [phoneTextField, fullnameTextField, address1TextField, address2TextField, cityTextField ,zipCodeTextField].forEach {
      $0?.isUserInteractionEnabled = enable
    }
    let button: UIBarButtonItem
    if enable {
      button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editAction(sender:)))
      fullnameTextField.becomeFirstResponder()
    } else {
      button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction(sender:)))
      [phoneTextField, fullnameTextField, address1TextField, address2TextField, cityTextField ,zipCodeTextField].forEach {
        $0?.resignFirstResponder()
      }
      saveChanges()
    }
    navigationItem.setRightBarButton(button, animated: true)
  }
  
  private func saveChanges() {
    guard let fullname = fullnameTextField.text, let phonenumber = phoneTextField.text else { return }
    guard !fullname.isEmpty, !phonenumber.isEmpty else { return }
    contactInfoModel.update(fullname: fullname, phoneNumber: phonenumber, address1: address1TextField.text, address2: address2TextField.text, city: cityTextField.text, zipCode: zipCodeTextField.text)
  }
  
  @IBAction func deleteContact(_ sender: Any) {
    contactInfoModel.delete { [weak self] in
      self?.onDeleteContact?()
    }
  }
  
  @objc private func editAction(sender: UIBarButtonItem) {
    contactInfoModel.editMode()
  }
}

extension ContactInfoTableViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    saveChanges()
    return true
  }
}

extension ContactInfoTableViewController {
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20.0
  }
}


