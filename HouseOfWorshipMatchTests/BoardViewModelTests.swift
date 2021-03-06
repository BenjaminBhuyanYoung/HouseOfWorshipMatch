//Created by Benjamin Bhuyan Young

import XCTest

class BoardViewModelTests: XCTestCase {
    
    func testCreateCardsMakesAllCardsWithDelegates() {
        let target = BoardViewModel(for: .normal)

        let expectedCardCount = Location.allCases.count * 2

        XCTAssertEqual(target.getCards().count, expectedCardCount)

        for card in target.getCards() {
            XCTAssertNotNil(card.delegate)
        }
    }

    // BUGBUG: Why can't I use this expectation?  I don't need it... but it should work.
    func testCardClickedCallsCardDelegate() {
        let target = BoardViewModel(for: .normal)
//        let expectation = XCTestExpectation(description: "delegate called cardClicked")
        var cardTapped = false

        let cardHandler = FakeCardHandler(cardTappedFunction: {
            cardTapped = true
//            expectation.fulfill()
        })

        let card = target.getCards().first
        card?.delegate = cardHandler

        card?.tap(nil)
//        waitForExpectations(timeout: 1.0)
        
        XCTAssertTrue(cardTapped)
    }

}
