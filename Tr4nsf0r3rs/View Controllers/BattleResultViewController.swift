//
//  BattleResultViewController.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

class BattleResultViewController: UIViewController {

    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team2Label: UILabel!
    
    @IBOutlet weak var victoryLabel: UILabel!
    
    @IBOutlet weak var battleResultDescription: UITextView!
    
    var battle: TBattle! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.battle != nil {
            //Set opponents label!
            self.team1Label.text = self.battle.team1.name
            self.team2Label.text = self.battle.team2.name
            
            // Start fight!
            self.battle.startfight()
            self.victoryLabel.text = self.battle.winnerTeam
            //Set description
            let (survivorsT1, survivorsT2) = self.battle.getTeamsSurvivors()
            self.battleResultDescription.text = "There has been \(self.battle.numBattles) battle(s)\n\n \(self.battle.team1.name) team survivors: \(survivorsT1) \n\n\(self.battle.team2.name) team survivors: \(survivorsT2)\n"
        } else {
            print("Error setting battle teams")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
