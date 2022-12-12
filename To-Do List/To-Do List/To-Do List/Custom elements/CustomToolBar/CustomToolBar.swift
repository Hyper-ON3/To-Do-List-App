//
//  CustomToolBar.swift
//  To-Do List
//
//  Created by Aleksey Kotsevych on 09/12/2022.
//

import UIKit

protocol CustomToolBarDelegate {
    func toolBarButtonsPressed(_ senderTag: Int)
}

class CustomToolBar: BaseUIViewComponent {

    @IBOutlet weak var centralButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    
    var delegate: CustomToolBarDelegate?
    
    func configuringToolBarElements() {
        centralButton.clipsToBounds = true
        centralButton.layer.cornerRadius = 0.5 * centralButton.bounds.size.width
    }
    
    func buttonAnimations(_ button: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0) {
            button.alpha = 0.6
        } completion: { completed in
            button.alpha = 1
        }
    }
    
    
    @IBAction func toolBarButtonsPressed(_ sender: UIButton) {
        //delegate?.toolBarButtonsPressed(sender.tag)
        switch sender.tag {
        case 0:
            delegate?.toolBarButtonsPressed(0)
            buttonAnimations(menuButton)
            print("Menu button pressed")
        case 1:
            delegate?.toolBarButtonsPressed(1)
            buttonAnimations(centralButton)
            print("Central button pressed")
        case 2:
            delegate?.toolBarButtonsPressed(2)
            buttonAnimations(calendarButton)
            print("Calendar button pressed")
        default: return
        }
    }
    
}
