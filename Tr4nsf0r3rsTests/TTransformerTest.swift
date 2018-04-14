//
//  TTransformerTest.swift
//  TTransformerTest
//
//  Created by Daniel Bolivar herrera on 14/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import XCTest


class TTransformerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSkillsUpperLimit() {
        //Test creation of Transformer object and that values are lower than the upper limit
        
        let trans = Transformer(strenght: 20, intelligence: 20, speed: 20, endurance: 20, rank: 20, courage: 20, firepower: 20, skill: 20)
        
        XCTAssertEqual(trans.strenght, 10)
        XCTAssertEqual(trans.intelligence, 10)
        XCTAssertEqual(trans.speed, 10)
        XCTAssertEqual(trans.endurance, 10)
        XCTAssertEqual(trans.rank, 10)
        XCTAssertEqual(trans.courage, 10)
        XCTAssertEqual(trans.firepower, 10)
        XCTAssertEqual(trans.skill, 10)
    }
    
    func testSkillLowerLimit() {
        //Test creation of Transformer object and that values are higher than lower limit
        
        let trans = Transformer(strenght: -20, intelligence: -20, speed: -20, endurance: -20, rank: -20, courage: -20, firepower: -20, skill: -20)
        
        XCTAssertEqual(trans.strenght, 1)
        XCTAssertEqual(trans.intelligence, 1)
        XCTAssertEqual(trans.speed, 1)
        XCTAssertEqual(trans.endurance, 1)
        XCTAssertEqual(trans.rank, 1)
        XCTAssertEqual(trans.courage, 1)
        XCTAssertEqual(trans.firepower, 1)
        XCTAssertEqual(trans.skill, 1)
    }
    
    func testCreation() {
        //Test creation of Transformer object and the integrity of their values
        
        let trans = Transformer(strenght: 1, intelligence: 2, speed: 3, endurance: 4, rank: 5, courage: 6, firepower: 7, skill: 8)
        
        XCTAssertEqual(trans.strenght, 1)
        XCTAssertEqual(trans.intelligence, 2)
        XCTAssertEqual(trans.speed, 3)
        XCTAssertEqual(trans.endurance, 4)
        XCTAssertEqual(trans.rank, 5)
        XCTAssertEqual(trans.courage, 6)
        XCTAssertEqual(trans.firepower, 7)
        XCTAssertEqual(trans.skill, 8)
        XCTAssertEqual(trans.overalRating, trans.strenght + trans.intelligence + trans.speed + trans.endurance + trans.firepower)
    }
    
}
