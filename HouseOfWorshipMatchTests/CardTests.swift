//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import XCTest
@testable import HouseOfWorshipMatch

class CardTests: XCTestCase {

    func testFactsCycle() {
        let card = Card(location: .uganda, type: .image, cardBack: .leaves, size: .small)

        let fact1 = card.getFact()
        let fact2 = card.getFact()
        let fact3 = card.getFact()
        let fact1Again = card.getFact()

        XCTAssertNotEqual(fact1, fact2)
        XCTAssertNotEqual(fact2, fact3)
        XCTAssertNotEqual(fact1, fact3)
        XCTAssertEqual(fact1, fact1Again)
    }

    func testFactsEndWithNumbering() {
        let card = Card(location: .germany, type: .image, cardBack: .leaves, size: .small)

        let fact1 = card.getFact()
        let fact2 = card.getFact()
        let fact1Again = card.getFact()

        let fact1Last9Characters = fact1.suffix(9)
        let fact2Last9Characters = fact2.suffix(9)
        let fact1AgainLast9Characters = fact1Again.suffix(9)

        XCTAssertEqual(fact1Last9Characters, " [1 of 2]")
        XCTAssertEqual(fact2Last9Characters, " [2 of 2]")
        XCTAssertEqual(fact1AgainLast9Characters, " [1 of 2]")
    }

    func testCardFaceTogglesWhenFlipping() {
        let card = Card(location: .india, type: .image, cardBack: .leaves, size: .small)

        XCTAssertTrue(card.faceUp)

        card.flip()
        XCTAssertFalse(card.faceUp)

        card.flip()
        XCTAssertTrue(card.faceUp)
    }

    func testCardGlows() {
        let card = Card(location: .samoa, type: .image, cardBack: .leaves, size: .small)

        let tapped: ()->() = {
            card.glow(on: true, animated: false)
        }
        card.delegate = FakeCardHandler(cardTappedFunction: tapped)

        XCTAssertEqual(card.layer.shadowOpacity, Float(0.0))

        card.tap(nil)

        XCTAssertEqual(card.layer.shadowOpacity, Card.glowOpacity)
    }
}

