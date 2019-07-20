//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import Foundation
import GameKit

public enum Level: Int {
    case tutorial, normal
}

class BoardViewModel {

    private var allCards = [Card]()
    private var selectedCards = [Card]()
    private let level: Level

    public init(for level: Level) {
        self.level = level

        switch level {
        case .tutorial:
            createCards(faceUp: true)
        case .normal:
            createCards(faceUp: false)
        }
        shuffleCards()
    }

    private func createCards(faceUp: Bool) {
        assert(allCards.count == 0)

        for location in Location.allCases {
            let pictureCard = Card(location: location, type: .image, cardBack: .star, size: .small)
            let textCard = Card(location: location, type: .text, cardBack: .star, size: .small)
            pictureCard.delegate = self
            textCard.delegate = self

            pictureCard.faceUp = faceUp
            textCard.faceUp = faceUp

            allCards.append(pictureCard)
            allCards.append(textCard)
        }
    }

    private func shuffleCards() {
        allCards = allCards.shuffled()
    }

    private func toggleSelected(card: Card) {
        var activate = true

        if let index = selectedCards.firstIndex(where: {$0 == card}) {
            selectedCards.remove(at: index)
            activate = false
        } else {
            selectedCards.append(card)
        }

        switch level {
        case .tutorial:
            card.glow(on: activate, animated: true)
        default:
            card.flip()
        }
    }

    @discardableResult
    private func checkMatch() -> Bool {
        if selectedCards.count == 2 && selectedCards[0].location == selectedCards[1].location {
            debugPrint("Match!")
            return true
        } else {
            if selectedCards.count == 2 {
                debugPrint("No match")
            }
            return false
        }
    }
}

extension BoardViewModel: BoardViewModelProtocol {
    public func getCards() -> [Card] {
        return allCards
    }
}

extension BoardViewModel: CardHandlerProtocol {
    public func cardTapped(card: Card) {
//        debugPrint("Card \(card.location) tapped.")

        toggleSelected(card: card)
        checkMatch()
    }
}
