//
//  MemberEditorTableViewController.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import RMessage

protocol NewMemberProtocol: class {
    func newMember(member: Transformer)
}

class MemberEditorTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var strength: UITextField!
    
    @IBOutlet weak var intelligence: UITextField!
    
    @IBOutlet weak var speed: UITextField!
    
    @IBOutlet weak var endurance: UITextField!
    
    @IBOutlet weak var rank: UITextField!
    
    @IBOutlet weak var courage: UITextField!
    
    @IBOutlet weak var firepower: UITextField!
    
    @IBOutlet weak var skill: UITextField!
    
    var member: Transformer! = nil
    
    weak var delegate: NewMemberProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if member != nil {
            //Editing member
            self.name.text = member.name
            self.strength.text = String(member.strength)
            self.intelligence.text = String(member.intelligence)
            self.speed.text = String(member.speed)
            self.endurance.text = String(member.endurance)
            self.rank.text = String(member.rank)
            self.courage.text = String(member.courage)
            self.firepower.text = String(member.firepower)
            self.skill.text = String(member.skill)
        }
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func save(_ sender: Any) {
        
        //Save values
        guard let name = self.name.text,
                let stre = Int(self.strength.text!),
                let intell = Int(self.intelligence.text!),
                let spd = Int(self.speed.text!),
                let end = Int(self.endurance.text!),
                let rk = Int(self.rank.text!),
                let cour = Int(self.courage.text!),
                let fp = Int(self.firepower.text!),
                let skll = Int(self.skill.text!)
        
            else {
                RMessage.showNotification(withTitle: "The transformer is missing some information", subtitle: "", type: .error, customTypeName: "", callback: nil)
                return
            }
        
        self.member = Transformer(name: name, strength: stre, intelligence: intell, speed: spd, endurance: end, rank: rk, courage: cour, firepower: fp, skill: skll)
        
        self.delegate?.newMember(member: self.member)
        
        //Dismiss TVC
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != self.name {
            guard let intValue = Int(textField.text!) else { return }
            textField.text = String(intValue.clamped(to: SpecsRange.min...SpecsRange.max))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
