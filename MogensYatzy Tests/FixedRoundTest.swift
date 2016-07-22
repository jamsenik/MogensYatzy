//
//  FixedRoundTest.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 21/07/16.
//
//

import XCTest
@testable import MogensYatzy

class FixedRoundTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNotInPattern() {
        let sut = FixedRound(pattern: [3, 3, 4, 5])
        sut.Add(1)
        XCTAssert(sut.Blank())
    }
    
    func testCanBeNext() {
        let sut = FixedRound(pattern: [3, 3, 4, 5])
        XCTAssert(sut.CanBeNext(3))
        XCTAssert(!sut.CanBeNext(1))
    }

    func testComplete() {
        let sut = FixedRound(pattern: [3, 3, 4, 5])
        sut.Add(3)
        XCTAssert(!sut.IsIncomplete())
    }
    
    func testScore() {
        let sut = FixedRound(pattern: [3, 3, 4, 5], bonus: 100)
        sut.Add(3)
        XCTAssertEqual(115, sut.Score())
    }
    
    func testScratch() {
        let sut = FixedRound(pattern: [3, 3, 4, 5])
        sut.Add(4)
        sut.Scratch()
        XCTAssertEqual("X", sut.ToString())
        XCTAssertEqual(0, sut.Score())
    }
    
    func testAddingAndDeleting() {
        let sut = FixedRound(pattern: [3, 3, 4, 5])
        sut.Add(3)
        sut.Back()
        sut.Add(3)
        XCTAssertEqual(15, sut.Score())
    }
    
    
}
