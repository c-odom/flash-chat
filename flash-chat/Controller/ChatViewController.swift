//
//  ChatViewController.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/11/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    //MARK: - Properties
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = K.appName
        navigationItem.hidesBackButton = true
        setupTableView()
        loadMessages()
    }
    
    //MARK: - Functions
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener {[weak self] (snapshot, error) in
                self?.messages = []
                guard error == nil else {return}
                guard let documents = snapshot?.documents else {return}
                for document in documents {
                    
                    let data = document.data()
                    guard let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String else {return}
                    let message = Message(sender: sender, body: body)
                    self?.messages.append(message)
                    DispatchQueue.main.async {
                        guard let strongSelf = self else { return }
                        strongSelf.tableView.reloadData()
                        let indexPath = IndexPath(row: strongSelf.messages.count - 1, section: 0)
                        strongSelf.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
    }
    
    //MARK: - IBActions
    @IBAction func onSendButtonPressed(_ sender: UIButton) {
        guard let messageBody = messageTextfield.text, let sender = Auth.auth().currentUser?.email else {return}
        db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: sender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) {[weak self] error in
            guard error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.messageTextfield.text = ""
            }
        }
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
        let message = messages[indexPath.row]
        let fromMe = Auth.auth().currentUser?.email == message.sender
        cell.setupMessageCell(fromMe: fromMe, message: message.body)
        return cell
    }
}
