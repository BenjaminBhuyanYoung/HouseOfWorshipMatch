//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import Foundation

public enum Level: Int {
    case tutorial, normal
}

class BoardViewModel {

    public var cards = [Card]()

    public init(for level: Level) {

        switch level {
        case .tutorial:
            createCards(faceUp: true)
        case .normal:
            createCards(faceUp: false)
        }
    }

    private func createCards(faceUp: Bool) {
        assert(cards.count == 0)

        for location in Location.all {
            let pictureCard = Card(location: location, type: .image, cardBack: .star, size: .small)
            let textCard = Card(location: location, type: .text, cardBack: .star, size: .small)
            pictureCard.delegate = self
            textCard.delegate = self

            cards.append(pictureCard)
            cards.append(textCard)
        }
    }
}

extension BoardViewModel: BoardViewModelProtocol {

}

extension BoardViewModel: CardHandlerProtocol {
    func cardClicked(card: Card) {
        debugPrint("Card \(card.location) clicked.")
    }
}
