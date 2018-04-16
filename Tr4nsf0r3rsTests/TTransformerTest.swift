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
        
        let trans = Transformer(name: "Manolo", strength: 20, intelligence: 20, speed: 20, endurance: 20, rank: 20, courage: 20, firepower: 20, skill: 20)
        
        XCTAssertEqual(trans.strength, 10)
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
        
        let trans = Transformer(name: "Manolo", strength: -20, intelligence: -20, speed: -20, endurance: -20, rank: -20, courage: -20, firepower: -20, skill: -20)
        
        XCTAssertEqual(trans.strength, 1)
        XCTAssertEqual(trans.intelligence, 1)
        XCTAssertEqual(trans.speed, 1)
        XCTAssertEqual(trans.endurance, 1)
        XCTAssertEqual(trans.rank, 1)
        XCTAssertEqual(trans.courage, 1)
        XCTAssertEqual(trans.firepower, 1)
        XCTAssertEqual(trans.skill, 1)
    }
    
    func testInit() {
        //Test creation of Transformer object and the integrity of their values
        
        let trans = Transformer(name: "Manolo", strength: 1, intelligence: 2, speed: 3, endurance: 4, rank: 5, courage: 6, firepower: 7, skill: 8)
        XCTAssertEqual(trans.name, "Manolo")
        XCTAssertEqual(trans.strength, 1)
        XCTAssertEqual(trans.intelligence, 2)
        XCTAssertEqual(trans.speed, 3)
        XCTAssertEqual(trans.endurance, 4)
        XCTAssertEqual(trans.rank, 5)
        XCTAssertEqual(trans.courage, 6)
        XCTAssertEqual(trans.firepower, 7)
        XCTAssertEqual(trans.skill, 8)
        XCTAssertTrue(trans.isAlive!)
        XCTAssertEqual(trans.overalRating, trans.strength + trans.intelligence + trans.speed + trans.endurance + trans.firepower)
    }
    
    func testJSONDictInit() {
        //Test creation from json object
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "TransformerTest", withExtension: "json") else {
            XCTFail("Missing file: TransformerTest.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            let transformer = try JSONDecoder().decode(Transformer.self, from: jsonContents)
            
            XCTAssertEqual(transformer.name, "Soundwave")
            XCTAssertEqual(transformer.strength, 8)
            XCTAssertEqual(transformer.intelligence, 9)
            XCTAssertEqual(transformer.speed, 2)
            XCTAssertEqual(transformer.endurance, 6)
            XCTAssertEqual(transformer.rank, 7)
            XCTAssertEqual(transformer.courage, 5)
            XCTAssertEqual(transformer.firepower, 6)
            XCTAssertEqual(transformer.skill, 10) // 20 in json, check filtering
            XCTAssertTrue(transformer.isAlive!)
            XCTAssertEqual(transformer.overalRating, transformer.strength + transformer.intelligence + transformer.speed + transformer.endurance + transformer.firepower)
            
        } catch {
            XCTFail("Wrong file: TransformerTest.json")
        }
    }
    
}
