//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import UIKit

public enum CardBack: String {
    case marble = "cardBack1",
    star = "starBorder",
    leaves = "leaves",
    maple = "leaves_maples"
}

public enum Location: String {
    case australia = "Sydney__Australia",
    germany = "Frankfurt__Germany",
    india = "New_Delhi__India",
    israel = "Haifa__Israel",
    panama = "Panama_City__Panama",
    samoa = "Apia__Samoa",
    turkmenistan = "Ashkabad__Turkmenistan",
    uganda = "Kampala__Uganda",
    usa = "Wilmette__USA"

    static var all:[Location] {
        return [.australia, .germany, .india, .israel, .panama, .samoa, .turkmenistan, .uganda, .usa]
    }
}

public enum CardType: Int {
    case image, text
}

public enum CardSize: Int {
    case small, medium, large
}

private var CardFact: [Location: [String]] = [
    .australia: [
        "The Australian House of Worship was dedicated in 1961 in Ingleside, a Sydney suburb.  The final piece of the dome was placed by helicopter.",
        "The walls of this House of Worship are white concrete with quartz aggregate.  Wet concrete was brushed away from the quartz to create a beautiful, durable surface."],
    .germany: [
        "The European Mother Temple was dedicated in 1964 in Langenhain near Frankfurt, Germany.",
        "The 540 diamond-shaped windows and ledges create outstanding acoustics inside the German House of Worship."],
    .india: [
        "Completed in 1986, the House of Worship in New Delhi is built around the concept of a lotus flower with 27 petals grouped 3 on a side.",
        "Over 800 people worked together in the construction of this House of Worship.",
        "The Indian House of Worship is one of the most visited buildings in the world.",
        "The new Institute Building has space for multiple classes and even has a dormitory."],
    .israel: [
        "An obelisk, built in 1971, stands at the future site of a House of Worship in Israel.",
        "The obelisk was built near the spot where Bahá’u’lláh chanted the Tablet of Carmel.",
        "The Temple Land where the Obelisk stands is about a mile (1.5 km) away from the Shrine of the Bab."],
    .panama: [
        "The Mother Temple of Latin America was completed in 1972 (although a House of Worship has since been built in Chile).",
        "The dome of this House of Worship is covered with thousands of small oval tiles.  The stonework is based upon Native American fabric designs."],
    .samoa: [
        "Dedicated in 1984 as the Mother Temple of the Pacific Islands.  The roof is based on a traditional Samoan house called a fale.",
        "The foundation stone was laid by Hand of the Cause Ruhiyyih Rabbani & His Highness Susuga Malietoa Tanumafili II, the first Bahá’í Head of State of a country."],
    .turkmenistan: [
        "The first House of Worship was completed in 1908 in a Russian-ruled area called \"Transcaspia.\"",
        "The original House of Worship was demolished in 1963 and is now a public park.",
        "In 1938 the government closed the temple to Bahá’ís, and a 1948 earthquake and subsequent heavy rains made the structure unsafe."],
    .uganda: [
        "The Mother Temple of Africa was dedicated in 1961.  Construction began in 1957, one month before The Guardian's death.",
        "The shape of this House of Worship is reminiscent of a traditional African hut.",
        "At the time this House of Worship was dedicated, it was the tallest structure in East Africa (nearly 38 meters/125 feet)."],
    .usa: [
        "Construction began on the Mother Temple of the West in 1921 and finished in 1953, over 30 years later.",
        "While the American House of Worship was being built, Bahá’ís were able to use the Foundation Hall.",
        "This is the oldest and largest House of Worship in the world today.  The architect, Louis Bourgeois, called it a \"great bell, calling to America.\""]
]

class Card: UIView {
    let location: Location
    private let front: UIView
    private let back: UIImageView

    private var faceUp = true
    private var factCounter = 0

    public var delegate: CardHandlerProtocol?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(location: Location, type: CardType, cardBack: CardBack, size: CardSize) {
        self.location = location
        let cardFrame = Card.calculateFrame(for: size)

        switch type {
        case .image:
            let image = UIImage(named: location.rawValue)
            front = UIImageView(image: image)
        case .text:
            front = UIView(frame: cardFrame)
            front.backgroundColor = UIColor.white

            Card.addLocationLabels(for: location, to: front)
        }
        self.back = UIImageView(image: UIImage(named: cardBack.rawValue))

        super.init(frame: cardFrame)

        front.contentMode = .scaleAspectFit
        back.contentMode = .scaleAspectFit


        for view in [self, front, back] {
            view.frame = cardFrame
            view.frame.origin.x = cardFrame.width / 2
            view.frame.origin.y = cardFrame.height / 2
        }

        addSubview(front)

        let gesture = UITapGestureRecognizer(target: self, action: #selector (tap(_:)))
        addGestureRecognizer(gesture)
    }

    static private func calculateFrame(for size: CardSize) -> CGRect {
        let screenHeight = UIScreen.main.bounds.height
        let safeInsets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // UIApplication.shared.keyWindow?.safeAreaInsets is zero -- is that right
        // not sure if I should us left/right or top/bottom in this orientation
        let usableHeight = screenHeight - safeInsets.left - safeInsets.right
        let cardHeight = usableHeight / 5

        switch size {
        case .small:
            return CGRect(x: 0, y: 0, width: cardHeight * 0.75, height: cardHeight)
        case .medium:
            return CGRect(x: 0, y: 0, width: 16, height: 24) // TODO
        case .large:
            return CGRect(x: 0, y: 0, width: 30, height: 45)
        }
    }

    static private func addLocationLabels(for location: Location, to view:UIView) {
        let cityLabel = UILabel()
        let countryLabel = UILabel()
        let halves = location.rawValue.components(separatedBy: "__")
        assert(halves.count == 2)
        let city = halves[0].replacingOccurrences(of: "_", with: " ")
        let country = halves[1].replacingOccurrences(of: "_", with: " ")

        for label in [cityLabel, countryLabel] {
            label.numberOfLines = -1
            label.adjustsFontForContentSizeCategory = true
            label.textAlignment = .center
            label.minimumScaleFactor = 0.1
            label.adjustsFontSizeToFitWidth = true
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
        }

        cityLabel.text = city
        countryLabel.text = country

        view.addSubview(cityLabel)
        view.addSubview(countryLabel)

        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 6),
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height / 6)
            ])
    }

    private func flip() {
        let toView = faceUp ? back : front
        let fromView = faceUp ? front : back
        UIView.transition(from: fromView, to: toView, duration: 0.7, options: .transitionFlipFromLeft, completion: nil)

        faceUp = !faceUp
    }

    @objc func tap(_ sender: UIGestureRecognizer?) {
        flip()
        delegate?.cardTapped(card: self)
    }

    public func getFact() -> String {
        assert(CardFact.keys.contains(location))
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

