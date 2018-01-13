//
//  ContactsViewController.swift
//  test_PhoneBook
//
//  Created by Pavel Shatalov on 13.01.2018.
//  Copyright © 2018 Pavel Shatalov. All rights reserved.
//

import UIKit


class ContactsViewController: UIViewController, ContactsView {
  
  var didSelectContact: ((Contact) -> ())?
  var didSelectNewContact: (() -> ())?
  var contactsModel: ContactsModel!
  
  @IBOutlet weak var tableView: UITableView!
  //private var contacts = [Contact]()
  private var contacts = [String: [Contact]]()
  enum State {
    case showContacts([String: [Contact]])
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    configureUI()
    contactsModel.viewNotificationBlock = { [weak self] state in
      DispatchQueue.main.async {
        self?.renderUI(state: state)
      }
    }
    contactsModel.fetchInitialDataFromJSON()
    contactsModel.fetchAllContacts()
  }
  
  private func configureUI() {
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(sender:)))
    navigationItem.setRightBarButton(addButton, animated: true)
    tableView.setContentInsetAdjustment(enabled: false, in: self)
    self.title = "Contacts"
  }
  
  @objc dynamic func addAction(sender: UIBarButtonItem) {
    didSelectNewContact?()
  }
  
  
  private func renderUI(state: State) {
    switch state {
      case .showContacts(let contacts):
        self.contacts = contacts
        print(contacts)
        tableView.reloadData()
    }
  }
  
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return contacts.keys.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let key = Array(contacts.keys)[section]
    guard let count = contacts[key]?.count else { return 0 }
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
    let key = Array(contacts.keys)[indexPath.section]
    guard let contactsInSection = contacts[key] else { return UITableViewCell () }
    let contact = contactsInSection[indexPath.row]
    cell.textLabel?.text = contact.firstName + " " + contact.lastName
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let key = Array(contacts.keys)[section]
    return key
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let key = Array(contacts.keys)[indexPath.section]
    guard let contactsInSection = contacts[key] else { return }
    let contact = contactsInSection[indexPath.row]
    didSelectContact?(contact)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
