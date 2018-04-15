//
//  TTeamTest.swift
//  Tr4nsf0r3rsTests
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import XCTest

class TTeamTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONDictInit() {
        //Test creation from json object
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "TeamTest", withExtension: "json") else {
            XCTFail("Missing file: TeamTest.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            let team = try JSONDecoder().decode(Team.self, from: jsonContents)
        
            XCTAssertEqual(team.name, "AutoBots")
            XCTAssertEqual(team.members.count, 2)
            
            //Check team sorted by rank
            var lastRank = 10
            for member in team.members {
                if lastRank < member.rank {
                    XCTFail("Team members are not sorted by rank")
                }
                lastRank = member.rank
            }
            
        } catch {
            XCTFail("Wrong file: TeamTest.json")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
