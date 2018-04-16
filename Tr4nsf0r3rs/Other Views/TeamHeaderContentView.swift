//
//  TeamHeaderContentView.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

protocol teamHeaderDelegate: class {
    func teamNameChanged(newName: String, team: Int)
    func addMember(for team: Int)
}

class TeamHeaderDetailView: UIView, UITextFieldDelegate {

    var team: Int = -1
    
    weak var delegate:teamHeaderDelegate?
    
    @IBOutlet weak var teamName: UITextField!

    @IBAction func addMember(_ sender: Any) {
        self.delegate?.addMember(for: self.team)
    }
    
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
