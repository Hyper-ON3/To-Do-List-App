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
    
    //private var taskModel: TasksModel?
    private var tasksArray = [TasksModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTabBar.configuringTabBarElements()
        customTabBar.delegate = self
        
        customToolBar.configuringToolBarElements()
        customToolBar.delegate = self
        
        taskTableView.register(UINib.init(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        customTextFieldView.delegate = self
        customTextFieldView.textField.delegate = self
        customTextFieldView.configuringCustomTFElements()
        customTextFieldView.isHidden = true
    }
    
    private func upgradeUI() {
        taskTableView.reloadData()
        customTextFieldView.isHidden = true
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            customTextFieldView.textField.resignFirstResponder()
            customTextFieldView.textField.text = ""
        }
        
        for subview in self.view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    private func blurEffect() {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: effect)
        blurEffectView.frame = view.bounds
        
        view.addSubview(blurEffectView)
        view.addSubview(customTextFieldView)
    }
    
    private func registerFromKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if self.view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        upgradeUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        deregisterFromKeyboardNotifications()
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
            registerFromKeyboardNotifications()
            blurEffect()
            customTextFieldView.isHidden = false
            customTextFieldView.textField.becomeFirstResponder()
        }
    }
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else { return UITableViewCell() }
        
        let task = tasksArray[indexPath.row].task
        
        cell.configuringCellElements()
        cell.taskLabel.text = task
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completed in
            
            self.tasksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completed(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension TasksViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        deregisterFromKeyboardNotifications()
        
        return true
    }
}

extension TasksViewController: CustomTextFieldDelegate {
    func createTaskButtonTapped(_ task: String?) {
        guard let tasks = task else { return }
        
        let task = TasksModel(task: tasks, date: "")
        tasksArray.append(task)
        
        upgradeUI()
        deregisterFromKeyboardNotifications()
    }
    
}
