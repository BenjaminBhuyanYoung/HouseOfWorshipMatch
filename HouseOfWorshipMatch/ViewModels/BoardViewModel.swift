//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import Foundation
import GameKit

public enum Level: Int {
    case tutorial, normal
}

class BoardViewModel {

    private var cards = [Card]()

    public init(for level: Level) {

        switch level {
        case .tutorial:
            createCards(faceUp: true)
        case .normal:
            createCards(faceUp: false)
        }
        shuffleCards()
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

    private func shuffleCards() {
        //        cards.shuffle()   TODO: Swift 4.2
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards)
        cards = shuffled as! [Card]
    }

}

extension BoardViewModel: BoardViewModelProtocol {
    public func getCards() -> [Card] {
        return cards
    }
}

extension BoardViewModel: CardHandlerProtocol {
    func cardTapped(card: Card) {
        debugPrint("Card \(card.location) clicked.")
    }
}
