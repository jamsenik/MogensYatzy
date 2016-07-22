//
//  PatternRoundTest.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 21/07/16.
//
//

import XCTest
@testable import MogensYatzy

class PatternRoundTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIncomplete() {
        let sut = PatternRound(pattern: [3, 3])
        sut.Add(1)
        XCTAssert(sut.IsIncomplete())

    }

    func testCanBeNext() {
        let sut = PatternRound(pattern: [3, 3])
        sut.Add(1)
        XCTAssert(!sut.CanBeNext(1))
        XCTAssert(sut.CanBeNext(2))
        
    }
    
    func testComplete() {
        let sut = PatternRound(pattern: [3, 3])
        sut.Add(1)
        sut.Add(2)
        XCTAssert(!sut.IsIncomplete())
    }

    func testScore() {
        let sut = PatternRound(pattern: [3, 3])
        sut.Add(1)
        sut.Add(2)
        XCTAssertEqual(9, sut.Score())
    }

    func testScratch() {
        let sut = PatternRound(pattern: [3, 3])
        sut.Add(1)
        sut.Add(2)
        sut.Scratch()
        XCTAssertEqual("X", sut.ToString())
    }

    func testAddingAndDeleting() {
        let sut = PatternRound(pattern: [3, 3])
        sut.Add(1)
        sut.Add(2)
        sut.Back()
        sut.Add(3)
        XCTAssertEqual(12, sut.Score())
    }


}
