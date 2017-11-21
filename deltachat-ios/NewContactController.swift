//
//  NewContactController.swift
//  deltachat-ios
//
//  Created by Jonas Reinsch on 17.11.17.
//  Copyright © 2017 Jonas Reinsch. All rights reserved.
//

import UIKit

class NewContactController: UITableViewController {
    let nameCell = TextFieldCell.makeNameCell()
    let emailCell = TextFieldCell.makeEmailCell()
    var doneButton:UIBarButtonItem?
    var cancelButton:UIBarButtonItem?
    
    var model:(name:String, email:String) = ("", "") {
        didSet {
            if (Utils.isValid(model.email) && !model.name.isEmpty) {
                doneButton?.isEnabled = true
            } else {
                doneButton?.isEnabled = false
            }
        }
    }
    
    let cells:[UITableViewCell]
    
    init() {
        cells = [nameCell, emailCell]
        
        super.init(style: .grouped)
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NewContactController.saveContactButtonPressed))
        doneButton?.isEnabled = false
        navigationItem.rightBarButtonItem = doneButton
        
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(NewContactController.cancelButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
        
        nameCell.textField.addTarget(self, action: #selector(NewContactController.nameTextChanged), for: UIControlEvents.editingChanged)
        emailCell.textField.addTarget(self, action: #selector(NewContactController.emailTextChanged), for: UIControlEvents.editingChanged)
    }
    
    @objc func emailTextChanged() {
        let emailText = emailCell.textField.text ?? ""
        
        model.email = emailText
    }
                
    @objc func nameTextChanged() {
        let nameText = nameCell.textField.text ?? ""
        
        model.name = nameText
    }
    
    @objc func saveContactButtonPressed() {
        let contactId = mrmailbox_create_contact(mailboxPointer, self.model.name, self.model.email)
        navigationController?.popViewController(animated: true)
        
        
    }
    
    @objc func cancelButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Contact"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        return cells[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

