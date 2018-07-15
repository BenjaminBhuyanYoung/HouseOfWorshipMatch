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

    var all:[CardFront] {
        return [.australia, .germany, .india, .israel, .panama, .samoa, .turkmenistan, .uganda, .usa]
    }
}

private var CardFact: [CardFront: [String]] = [
    CardFront.australia: [
        "The Australian House of Worship was dedicated in 1961 in Ingleside, a Sydney suburb.  The final piece of the dome was placed by helicopter.",
        "The walls of this House of Worship are white concrete with quartz aggregate.  Wet concrete was brushed away from the quartz to create a beautiful, durable surface."],
    CardFront.germany: [
        "The European Mother Temple was dedicated in 1964 in Langenhain near Frankfurt, Germany.",
        "The 540 diamond-shaped windows and ledges create outstanding acoustics inside the German House of Worship."],
    CardFront.india: [
        "Completed in 1986, the House of Worship in New Delhi is built around the concept of a lotus flower with 27 petals grouped 3 on a side.",
        "Over 800 people worked together in the construction\nof this House of Worship.",
        "The Indian House of Worship is one of the most visited buildings in the world."],
    CardFront.israel: [
        "An obelisk, built in 1971, stands at the future site of a House of Worship in Israel.",
        "The obelisk was built near the spot where Bahá’u’lláh chanted the Tablet of Carmel.",
        "The Temple Land where the Obelisk stands is about a mile (1.5 km) away from the Shrine of the Bab."],
    CardFront.panama: [
        "The Mother Temple of Latin America was completed in 1972 (although a House of Worship has since been built in Chile).",
        "The dome of this House of Worship is covered with thousands of small oval tiles.  The stonework is based upon Native American fabric designs."],
    CardFront.samoa: [
        "Dedicated in 1984 as the Mother Temple of the Pacific Islands.  The roof is based on a traditional Samoan house called a fale.",
        "The foundation stone was laid by Hand of the Cause Ruhiyyih Rabbani & His Highness Susuga Malietoa Tanumafili II, the first Bahá’í Head of State of a country."],
    CardFront.turkmenistan: [
        "The first House of Worship was completed in 1908 in a Russian-ruled area called \"Transcaspia.\"",
        "The original House of Worship was demolished in 1963 and is now a public park.",
        "In 1938 the government closed the temple to Bahá’ís, and a 1948 earthquake and subsequent heavy rains made the structure unsafe."],
    CardFront.uganda: [
        "The Mother Temple of Africa was dedicated in 1961.  Construction began in 1957, one month before The Guardian's death.",
        "The shape of this House of Worship is reminiscent of a traditional African hut.",
        "At the time this House of Worship was dedicated, it was the tallest structure in East Africa (nearly 38 meters/125 feet)."],
    CardFront.usa: [
        "Construction began on the Mother Temple of the West in 1921 and finished in 1953, over 30 years later.",
        "While the American House of Worship was being built, Bahá’ís were able to use the Foundation Hall.",
        "This is the oldest and largest House of Worship in the world today.  The architect, Louis Bourgeois, called it a \"great bell, calling to America.\""]
]

class Card: UIView {
    let location: CardFront
    let front: UIImageView
    let back: UIImageView

    private var faceUp = true
    private var factCounter = 0

    // no... cardHandlerProtocol or something.  BoardViewModel can extend.
//    public var delegate: BoardViewModelProtocol?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(location: CardFront, cardBack: CardBack) {
        self.location = location
        let frontImage = UIImage(named: location.rawValue)
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

    public func getFact() -> String {
        guard var facts = CardFact[location] else {
            debugPrint("Error, missing fact for \(location)")
            return ""
        }

        if factCounter >= facts.count {
            factCounter = 0
        }

        let fact = facts[factCounter] + " [\(factCounter + 1) of \(facts.count)]"

        factCounter += 1

        return fact
    }
}

