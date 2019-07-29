//Created by Benjamin Bhuyan Young on 12/29/18

import Foundation

//Not explicity used...
protocol CardProtocol {
    var location: Location { get }
    var faceUp: Bool { get }
    var delegate: CardHandlerProtocol? { get set }

    func glow(on: Bool, animated: Bool)
    func flip()
    func getFact() -> String
    func disappear()
}
