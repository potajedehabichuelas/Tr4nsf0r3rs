//
//  Transformer.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 14/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

private struct TotalWinners {
    static let transformerNames = ["OPTIMUS PRIME", "PREDAKING"]
}

struct SpecsRange {
    static let max = 10
    static let min = 1
}

struct Transformer: Codable {
    
    var name: String
    
    var isAlive: Bool? = true

    var strength: Int {
        didSet {
            strength = strength.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var intelligence: Int {
        didSet {
            intelligence = intelligence.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var speed: Int {
        didSet {
            speed = speed.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var endurance: Int {
        didSet {
            endurance = endurance.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var rank: Int {
        didSet {
            rank = rank.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var courage: Int {
        didSet {
            courage = courage.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var firepower: Int {
        didSet {
            firepower = firepower.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var skill: Int {
        didSet {
            skill = skill.clamped(to: SpecsRange.min...SpecsRange.max)
        }
    }
    
    var overalRating: Int {
        return self.strength + self.intelligence + self.speed + self.endurance + self.firepower
    }
    
    init(name:String, strength: Int, intelligence: Int, speed: Int, endurance: Int, rank: Int, courage: Int, firepower: Int, skill: Int) {
        
        //Set all properties and make sure they're within their expected range
        //The didset observer is not called on init(), but it might be useful if we wanted to modify the properties
        //Alternatively we could also throw an error but in this case I've decided just to clamp the values
        
        self.name = name
        self.isAlive = true
        
        self.strength = strength.clamped(to: SpecsRange.min...SpecsRange.max)
        self.intelligence = intelligence.clamped(to: SpecsRange.min...SpecsRange.max)
        self.speed = speed.clamped(to: SpecsRange.min...SpecsRange.max)
        self.endurance = endurance.clamped(to: SpecsRange.min...SpecsRange.max)
        self.rank = rank.clamped(to: SpecsRange.min...SpecsRange.max)
        self.courage = courage.clamped(to: SpecsRange.min...SpecsRange.max)
        self.firepower = firepower.clamped(to: SpecsRange.min...SpecsRange.max)
        self.skill = skill.clamped(to: SpecsRange.min...SpecsRange.max)
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    
        self.name = try values.decode(String.self, forKey: .name)
        
        self.strength = try values.decode(Int.self, forKey: .strength).clamped(to: SpecsRange.min...SpecsRange.max)
        self.intelligence = try values.decode(Int.self, forKey: .intelligence).clamped(to: SpecsRange.min...SpecsRange.max)
        self.speed = try values.decode(Int.self, forKey: .speed).clamped(to: SpecsRange.min...SpecsRange.max)
        self.endurance = try values.decode(Int.self, forKey: .endurance).clamped(to: SpecsRange.min...SpecsRange.max)
        self.rank = try values.decode(Int.self, forKey: .rank).clamped(to: SpecsRange.min...SpecsRange.max)
        self.courage = try values.decode(Int.self, forKey: .courage).clamped(to: SpecsRange.min...SpecsRange.max)
        self.firepower = try values.decode(Int.self, forKey: .firepower).clamped(to: SpecsRange.min...SpecsRange.max)
        self.skill = try values.decode(Int.self, forKey: .skill).clamped(to: SpecsRange.min...SpecsRange.max)
        
        self.isAlive = true
    }
    
    func isTotalWinner() -> Bool {
        return TotalWinners.transformerNames.contains(self.name.uppercased()) ? true : false
    }

}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
