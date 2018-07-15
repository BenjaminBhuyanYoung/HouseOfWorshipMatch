//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import Foundation

public enum Level: Int {
    case tutorial, normal
}

class BoardViewModel {

    public init(for level: Level) {

        switch level {
        case .tutorial:
            createCards(faceUp: true)
        case .normal:
            createCards(faceUp: false)
        }
    }

    private func createCards(faceUp: Bool) {

    }
}

extension BoardViewModel: BoardViewModelProtocol {

}
