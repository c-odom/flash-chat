//
//  ChatViewController.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/11/20.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    //MARK: - Properties
    var messages: [Message] = [
        Message(sender: "jayz@gmail.com", body: "Hey!"),
        Message(sender: "walker@gmail.com", body: "Hello!"),
        Message(sender: "jayz@gmail.com", body: "Whats up?"),
    ]
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = K.appName
        navigationItem.hidesBackButton = true
        setupTableView()
    }
    
    //MARK: - Functions
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    //MARK: - IBActions
    @IBAction func onSendButtonPressed(_ sender: UIButton) {
    }
    @IBAction func onLogOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: false)
        } catch let error {
            print(error)
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        cell.label.text = messages[indexPath.row].body
        return cell
    }
}
