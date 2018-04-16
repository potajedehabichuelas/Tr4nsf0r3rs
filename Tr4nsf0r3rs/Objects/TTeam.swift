//
//  TTeam.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 14/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit

struct TTeam: Codable {
    
    var name: String
    
    var members: [Transformer] {
        didSet {
            self.members = self.members.sorted(by: { $0.rank > $1.rank })
        }
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        let members = try values.decode([Transformer].self, forKey: .members)
        self.members = members.sorted(by: { $0.rank > $1.rank })
    }
    
    init(name: String, members: [Transformer]) {
        self.name = name
        // Sort team based on its rank
        self.members = members.sorted(by: { $0.rank > $1.rank })
    }
}
