//
//  LoginViewController.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/11/20.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - IBActions
    @IBAction func onLogInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (authResult, error) in
            guard let strongSelf = self else { return }
            guard error == nil else {
                print(error!)
                return
            }
            strongSelf.performSegue(withIdentifier: K.loginSegue, sender: strongSelf)
        }
    }
}
