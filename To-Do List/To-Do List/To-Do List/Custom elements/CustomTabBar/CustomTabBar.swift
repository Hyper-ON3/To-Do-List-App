//
//  CustomTabBar.swift
//  To-Do List
//
//  Created by Aleksey Kotsevych on 09/12/2022.
//

import UIKit

protocol CustomTabBarDelegate {
    func tabBarButtonPressed()
}

class CustomTabBar: BaseUIViewComponent {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rightClearView: UIView!
    @IBOutlet weak var leftClearView: UIView!
    @IBOutlet weak var searchTextField: DesignableUITextField!
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var delegate: CustomTabBarDelegate?
    
    func configuringTabBarElements() {
        rightClearView.clipsToBounds = true
        rightClearView.layer.cornerRadius = 0.5 * rightClearView.bounds.size.width
        
        leftClearView.clipsToBounds = true
        leftClearView.layer.cornerRadius = 55
        
        searchTextField.clipsToBounds = true
        searchTextField.layer.cornerRadius = 15
    }
    
    private func buttonsAnimation(_ button: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0) {
            button.alpha = 0.6
        } completion: { completed in
            button.alpha = 1
        }

    }
    
    @IBAction func dashboardButtonPressed(_ sender: UIButton) {
        buttonsAnimation(dashboardButton)
        print("Dashboard button pressed")
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        buttonsAnimation(menuButton)
        print("Menu button pressed")
    }
}
