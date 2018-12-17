//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Noud on 28-11-18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    // MARK: properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isEndDatePickerHidden = true

    var todo: ToDo?
    
    // MARK: loads in the detailed information of the chosen ToDO
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompletedButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(60*60*24)
        }
        
        updateDueDateLabel(with: dueDatePickerView.date)
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func isCompletedTapped(_ sender: UIButton) {
        isCompletedButton.isSelected = !isCompletedButton.isSelected
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(with: dueDatePickerView.date)
    }

    // MARK: updates the UI corresponding to if the user wants to change the date and time or not
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44.0)
        let largeCellHeight = CGFloat(200.0)
        
        switch (indexPath.section, indexPath.row) {
        case (0,1):
            return isEndDatePickerHidden ? normalCellHeight : largeCellHeight
        case (1,0):
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    // MARK: calls the right functions if the user wants to change the date and time
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        switch (indexPath) {
        case [0,1]:
            isEndDatePickerHidden = !isEndDatePickerHidden
            
            dueDateLabel.textColor =
                isEndDatePickerHidden ? .black : tableView.tintColor
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default: break
        }
    }

    // MARK: if the user is done making changes and pressed the 'Done' button, the controller sends a segue with the updated information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isCompleted = isCompletedButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isCompleted, dueDate: dueDate, notes: notes)
    }

    // MARK: updates the 'Save' button according to the state
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: updates the 'DueDate' label according to the state
    func updateDueDateLabel(with date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
}
