//
//  TBattle.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 14/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

struct TBattle {

    private(set) var winnerTeam: String?
    
    private(set) var numBattles: Int
    
    private(set) var team1: TTeam
    
    private(set) var team2: TTeam
    
    private(set) var team1WinningRounds: Int
    
    private(set) var team2WinningRounds: Int
    
    init(team1: TTeam, team2: TTeam) {
        self.team1 = team1
        self.team2 = team2
        self.numBattles = 0
        self.team1WinningRounds = 0
        self.team2WinningRounds = 0
        self.winnerTeam = nil
    }
    
    mutating func setRoundWinner(roundIndex: Int, team1Winner: Bool) {
        
        if team1Winner {
            self.team1WinningRounds += 1
            //kill defeated member
            self.team2.members[roundIndex].isAlive = false
        } else {
            //Team 2 winner
            self.team2WinningRounds += 1
            //kill defeated member
            self.team1.members[roundIndex].isAlive = true
        }
    }
    
    func opponentRanAway(fighter: Transformer, opponent: Transformer) -> Bool {
        if fighter.courage - opponent.courage >= 4 && fighter.strength - opponent.strength >= 3  {
            return true
        } else {
            return false
        }
    }
    
    mutating func fight() {
        
        //Team which has less members dictates the max number of rounds
        let maxBattles = self.team2.members.count < self.team1.members.count ? self.team2.members.count : self.team1.members.count
        
        for i in 0..<maxBattles {
    
            self.numBattles += 1
            
            var fighter1 = self.team1.members[i]
            var fighter2 = self.team2.members[i]
            
            print("Fight: \(fighter1.name) vs \(fighter2.name)")
            
            //If a fighter is a total winner he wins regardless any other criteria
            let f1TotalWinner = fighter1.isTotalWinner()
            let f2TotalWinner = fighter2.isTotalWinner()
            
            //If both fighters are total winners the battle ends here
            if f1TotalWinner && f2TotalWinner {
                //All competitors is destroyed
                print("Result: Both fighters are total winner; All competitors destroyed")
                self.team1.members.removeAll()
                self.team2.members.removeAll()
                break
                
            } else if f1TotalWinner {
                //Fighter 1 wins round
                print("Result: \(fighter1.name) is a total winner")
                self.setRoundWinner(roundIndex: i, team1Winner: true)
                continue
            } else if f2TotalWinner {
                //Fighter 2 wins round
                print("Result: \(fighter2.name) is a total winner")
                self.setRoundWinner(roundIndex: i, team1Winner: false)
                continue
            }
            
            //If one of the fightesr is up 4 (or more) points of courage, and 3 (or more) points of strength, he wins
            if self.opponentRanAway(fighter: fighter1, opponent: fighter2) {
                self.setRoundWinner(roundIndex: i, team1Winner: true)
                continue
            } else if self.opponentRanAway(fighter: fighter2, opponent: fighter1) {
                self.setRoundWinner(roundIndex: i, team1Winner: false)
                continue
            }
            
            // If one of the fighters has 3 points of skill or more above his opponent's, he wins
            if abs(fighter2.skill - fighter1.skill) >= 3 {
                print("Result: \(fighter1.skill > fighter2.skill ? fighter1.name : fighter2.name) is so skilled he/she won!")
                let fighter1Winner = fighter1.skill > fighter2.skill
                self.setRoundWinner(roundIndex: i, team1Winner: fighter1Winner)
                continue
            }
            
            if fighter1.overalRating == fighter2.overalRating {
                //Tie, destroy both transformers
                print("Result: TIE!!! Both fighters have the same rating!")
                self.team1.members[i].isAlive = false
                self.team2.members[i].isAlive = false
            }
            
        }
    }
}
