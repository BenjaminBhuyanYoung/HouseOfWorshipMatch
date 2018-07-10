//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import UIKit

public enum CardBack: String {
    case marble = "cardBack1",
    star = "starBorder",
    leaves = "leaves",
    maple = "leaves_maples"
}

public enum CardFront: String {
    case australia = "Sydney__Australia",
    germany = "Frankfurt__Germany",
    india = "New_Delhi__India",
    israel = "Haifa__Israel",
    panama = "Panama_City__Panama",
    samoa = "Apia__Samoa",
    turkmenistan = "Ashkabad__Turmenistan",
    uganda = "Kampala__Uganda",
    usa = "Wilmette__USA"
}

class Card: UIView {
    let type: CardFront
    let front: UIImageView
    let back: UIImageView

    private var faceUp = true // while testing

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(type: CardFront, cardBack: CardBack) {
        self.type = type
        let frontImage = UIImage(named: type.rawValue)
        let backImage = UIImage(named: cardBack.rawValue)
        
        self.front = UIImageView(image: frontImage)
        self.back = UIImageView(image: backImage)

        front.contentMode = .scaleAspectFit
        back.contentMode = .scaleAspectFit
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

        addSubview(front)

        let gesture = UITapGestureRecognizer(target: self, action: #selector (flip(_:)))
        addGestureRecognizer(gesture)
    }

    @objc func flip(_ sender: UIGestureRecognizer) {
        let toView = faceUp ? back : front
        let fromView = faceUp ? front : back
        UIView.transition(from: fromView, to: toView, duration: 0.7, options: .transitionFlipFromRight, completion: nil)
        toView.translatesAutoresizingMaskIntoConstraints = false
        faceUp = !faceUp
    }

}

