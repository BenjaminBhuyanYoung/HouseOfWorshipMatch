//Created by Benjamin Bhuyan Young on __DATE__

import XCTest

class BoardViewModelTests: XCTestCase {
    
    func testCreateCardsMakesAllCardsWithDelegates() {
        let target = BoardViewModel(for: .normal)

        let expectedCardCount = Location.all.count * 2

        XCTAssertEqual(target.cards.count, expectedCardCount)

        for card in target.cards {
            XCTAssertNotNil(card.delegate)
        }
    }

    
}
