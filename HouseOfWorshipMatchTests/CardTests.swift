//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import XCTest
@testable import HouseOfWorshipMatch

class CardTests: XCTestCase {

    func testFactsCycle() {
        let card = Card(location: .india, type: .image, cardBack: .leaves, size: .small)

        let fact1 = card.getFact()
        let fact2 = card.getFact()
        let fact3 = card.getFact()
        let fact1Again = card.getFact()

        XCTAssertNotEqual(fact1, fact2)
        XCTAssertNotEqual(fact2, fact3)
        XCTAssertNotEqual(fact1, fact3)
        XCTAssertEqual(fact1, fact1Again)
    }

}
