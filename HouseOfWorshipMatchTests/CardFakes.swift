//Created by Benjamin Bhuyan Young on 7/20/19

import Foundation


class FakeCardHandler: CardHandlerProtocol {
    public var cardTappedFunction: ()->() = {}

    public init(cardTappedFunction: (()->())? = nil) {
        if let function = cardTappedFunction {
            self.cardTappedFunction = function
        }
    }

    func cardTapped(card: Card) {
        cardTappedFunction()
    }
}
