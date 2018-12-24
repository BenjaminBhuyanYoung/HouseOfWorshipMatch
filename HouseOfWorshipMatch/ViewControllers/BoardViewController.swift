//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import UIKit

class BoardViewController: UIViewController {
    private var background = UIImageView()
    private var cardsBoard = UIView()
    private var selectedBoard = UIView()
    private var quit = UIButton()

    public var viewModel: BoardViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        addBackground()
        addBoards()
        addCards()
        addQuitButton()
    }

    private func addBackground() {
        background.backgroundColor = UIColor.brown
        
        let bgImage = UIImage(named: "bg")
        background.contentMode = .scaleAspectFit
        background.image = bgImage
        
        view.addSubview(background)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.widthAnchor.constraint(equalTo: view.widthAnchor),
            background.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func addBoards() {
        for board in [cardsBoard, selectedBoard] {
            board.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
            board.layer.cornerRadius = 4.0
            
            board.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(cardsBoard)
        view.addSubview(selectedBoard)
        
        NSLayoutConstraint.activate([
            selectedBoard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            selectedBoard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
            selectedBoard.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            selectedBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

        NSLayoutConstraint.activate([
            cardsBoard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            cardsBoard.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
            cardsBoard.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            cardsBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

        // layout the cards board so the frame gets set -- needed when cards are added.
        cardsBoard.layoutIfNeeded()
    }

    private func addCards() {
        guard let cards = viewModel?.getCards() else {
            debugPrint("Error, no cards.")
            return
        }
        assert(cards.count >= 18)

        let xInterval = cardsBoard.bounds.width / 6
        let yInterval = cardsBoard.bounds.height / 3

        let halfCardWidth = cards[0].frame.width / 4
        let halfCardHeight = cards[0].frame.height / 4

        var index = 0
        for xCount in 0..<6 {
            for yCount in 0..<3 {
                let card = cards[index]
                card.frame.origin.x = xInterval * CGFloat(xCount) + halfCardWidth
                card.frame.origin.y = yInterval * CGFloat(yCount) + halfCardHeight
                cardsBoard.addSubview(card)

                index += 1
            }
        }
    }

    private func addQuitButton() {
        quit.backgroundColor = UIColor.black
        quit.setTitle(NSLocalizedString("Quit", comment: "Quit button"), for: .normal)
        quit.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        quit.setTitleColor(UIColor.purple, for: .normal)
        quit.layer.cornerRadius = 4
        
        view.addSubview(quit)
        
        quit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quit.widthAnchor.constraint(equalToConstant: 80),
            quit.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -3),
            quit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3)
            ])
        
        quit.addTarget(self, action: #selector(tappedQuit(_:)), for: .touchUpInside)
    }
    
    @objc func tappedQuit(_ sender: UIGestureRecognizer) {
        let mainMenuViewController = MainMenuViewController()
        
        guard let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate),
            let window = appDelegate.window else {
                debugPrint("tappedQuit: Error, no App Delegate or window.")
                return
        }
        window.rootViewController = mainMenuViewController
    }
}
