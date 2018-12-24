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
        assert(allCards.count == 0)

        for location in Location.allCases {
            let pictureCard = Card(location: location, type: .image, cardBack: .star, size: .small)
            let textCard = Card(location: location, type: .text, cardBack: .star, size: .small)
            pictureCard.delegate = self
            textCard.delegate = self

            allCards.append(pictureCard)
            allCards.append(textCard)
        }
    }

    private func shuffleCards() {
        //        cards.shuffle()   TODO: Swift 4.2
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allCards)
        allCards = shuffled as! [Card]
    }

}

extension BoardViewModel: BoardViewModelProtocol {
    public func getCards() -> [Card] {
        return allCards
    }
}

extension BoardViewModel: CardHandlerProtocol {
    private func addSelected(card: Card) {
        if !selectedCards.contains(card) {
            selectedCards.append(card)
        }
    }

    private func removeSelected(card: Card) {
        if let index = selectedCards.index(of: card) {
            selectedCards.remove(at: index)
        }
    }

    private func checkMatch() -> Bool {
        if selectedCards.count == 2 && selectedCards[0].location == selectedCards[1].location {
            debugPrint("Match!")
            return true
        } else {
            debugPrint("No match")
            return false
        }

    }

    public func cardTapped(card: Card) {
        debugPrint("Card \(card.location) clicked.")

        if card.faceUp {
            addSelected(card: card)
            _ = checkMatch()
        } else {
            removeSelected(card: card)
        }
    }
}
