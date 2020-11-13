//
//  ViewController.swift
//  flash-chat
//
//  Created by Jayz Walker on 11/11/20.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleNavigationBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        toggleNavigationBarHidden(false)
    }
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTitleAnimationUsingLoop()
//        setupTitleAnimationUsingCLTypeLabel()
    }
    
    //MARK: - Functions
    func toggleNavigationBarHidden(_ hidden: Bool) {
        navigationController?.isNavigationBarHidden = hidden
    }
    func setupTitleAnimationUsingLoop() {
        var charIndex = 0.0
        titleLabel.text = ""
        let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {[weak self] _ in
                self?.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func setupTitleAnimationUsingCLTypeLabel() {
        titleLabel.text = "⚡️FlashChat"
    }


}

