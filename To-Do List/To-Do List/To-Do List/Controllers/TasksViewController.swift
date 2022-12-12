//
//  TasksViewController.swift
//  To-Do List
//
//  Created by Aleksey Kotsevych on 09/12/2022.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var customTabBar: CustomTabBar!
    @IBOutlet weak var customToolBar: CustomToolBar!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var customTextFieldView: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBar.configuringTabBarElements()
        customTabBar.delegate = self
        
        customToolBar.configuringToolBarElements()
        customToolBar.delegate = self
        
        taskTableView.register(UINib.init(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        customTextFieldView.textField.delegate = self
        customTextFieldView.configuringCustomTFElements()
        customTextFieldView.isHidden = true
        
        registerFromKeyboardNotifications()
    }
    
    func blurEffect() {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = view.bounds
        
        view.addSubview(blurEffectView)
        view.addSubview(customTextFieldView)
    }
    
    func registerFromKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if self.view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardSize.height
            //customTextFieldView.frame.origin.y -= (keyboardSize.height - 35)
        }
 
        print(customTextFieldView.frame.origin.y)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        //guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            customTextFieldView.isHidden = true
            
            for subview in self.view.subviews {
                if subview is UIVisualEffectView {
                    subview.removeFromSuperview()
                }
            }

        }
         
//        if customTextFieldView.frame.origin.y != 0 {
//            customTextFieldView.frame.origin.y += keyboardSize.height
//            customTextFieldView.isHidden = true
//
//            for subview in self.view.subviews {
//                if subview is UIVisualEffectView {
//                    subview.removeFromSuperview()
//                }
//            }
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - Extensions

extension TasksViewController: CustomTabBarDelegate {
    func tabBarButtonPressed() {
        // Some code
    }
}

extension TasksViewController: CustomToolBarDelegate {
    
    func toolBarButtonsPressed(_ senderTag: Int) {
        
        if senderTag == 1 {
            blurEffect()
            customTextFieldView.isHidden = false
            customTextFieldView.textField.becomeFirstResponder()
        }
    }
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else { return UITableViewCell() }
        
        cell.configuringCellElements()
        
        return cell
    }
    
}

extension TasksViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
