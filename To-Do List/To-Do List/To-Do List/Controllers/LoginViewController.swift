//
//  ViewController.swift
//  To-Do List
//
//  Created by Aleksey Kotsevych on 09/12/2022.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {

    @IBOutlet weak var logoView: AnimationView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        logoView.loopMode = .loop
        logoView.play()
        configuringElements()
    }
    
    private func configuringElements() {
        emailTextField.clipsToBounds = true
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 0.5
        
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 0.5
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 20
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Tasks", bundle: nil).instantiateViewController(withIdentifier: "TasksViewController") as? TasksViewController else { return }
        
        present(vc, animated: true)
    }
}

