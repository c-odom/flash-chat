//
//  ChatViewController.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/11/20.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func onSendButtonPressed(_ sender: UIButton) {
    }
    
}
