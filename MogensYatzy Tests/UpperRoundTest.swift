//
//  UpperRoundTest.swift
//  MogensYatzy
//
//  Created by Hans Kyndesgaard on 21/07/16.
//
//

import XCTest
@testable import MogensYatzy

class UpperRoundTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testIncomplete() {
        let sut = UpperRound(kind: 3)
        sut.Add(3)
        XCTAssert(!sut.IsIncomplete())
        
    }
    
    func testCanBeNext() {
        let sut = UpperRound(kind: 3)
        sut.Add(3)
        XCTAssert(!sut.CanBeNext(1))
        XCTAssert(sut.CanBeNext(3))
        
    }
    
    func testComplete() {
        let sut = UpperRound(kind: 3)
        sut.Add(3)
        sut.Add(3)
        XCTAssert(!sut.IsIncomplete())
    }
    
    func testScore() {
        let sut = UpperRound(kind: 3)
        sut.Add(3)
        sut.Add(3)
        XCTAssertEqual(-6, sut.Score())
    }
    
    func testScratch() {
        let sut = UpperRound(kind: 3)
        sut.Add(3)
        sut.Add(3)
        sut.Scratch()
        XCTAssertEqual("X", sut.ToString())
    }
    
    func testAddingAndDeleting() {
        let sut = UpperRound(kind: 3)
        sut.Add(3)
        sut.Add(3)
        sut.Back()
        sut.Add(3)
        XCTAssertEqual(-6, sut.Score())
    }
}