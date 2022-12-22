//
//  CustomTableViewCell.swift
//  To-Do List
//
//  Created by Aleksey Kotsevych on 11/12/2022.
//

import UIKit
import SwipeCellKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuringCellElements() {
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 15
        
        taskLabel.lineBreakMode = .byWordWrapping
        taskLabel.numberOfLines = 0
    }
    
}
