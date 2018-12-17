//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Noud on 28-11-18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

// MARK: updates the checker according to the state
@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {

    // MARK: properties
    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: ToDoCellDelegate?
    
    // MARK: checks if the ToDo is checked and updates the data accordingly
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
