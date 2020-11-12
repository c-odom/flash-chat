//
//  RegisterViewController.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/11/20.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func onRegisterButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] (authData, error) in
            guard error == nil else {
                print(error!)
                return
            }
            self?.performSegue(withIdentifier: K.registerSegue, sender: self)
        }
        
    }
    

}
