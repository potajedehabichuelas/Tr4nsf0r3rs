//
//  TeamHeaderContentView.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

protocol teamNameDelegate: class {
    func teamNameChanged(newName: String, team: Int)
}

class TeamHeaderDetailView: UIView, UITextFieldDelegate {

    var team: Int = -1
    
    weak var delegate:teamNameDelegate?
    
    @IBOutlet weak var teamName: UITextField!
        
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if self.delegate != nil && self.team >= 0 {
            self.delegate?.teamNameChanged(newName: textField.text!, team: self.team)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    

}
