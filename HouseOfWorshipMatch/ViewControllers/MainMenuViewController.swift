//  Created by Benjamin Bhuyan Young on 7/9/18.
//  Copyright © 2018 The Raven Games. All rights reserved.

import UIKit

class MainMenuViewController: UIViewController {
    private var background = UIImageView()
    private var play = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        addBackground()
        addPlayButton()
    }
    
    private func addBackground() {
        background.backgroundColor = UIColor.brown
        
        let bgImage = UIImage(named: "world_with_stars3")
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
    
    private func addPlayButton() {
        play.backgroundColor = UIColor.black
        play.setTitle(NSLocalizedString("Play Game", comment: "Play Game button"), for: .normal)
        play.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        play.setTitleColor(UIColor.purple, for: .normal)
        play.layer.cornerRadius = 4
        
        view.addSubview(play)
        
        play.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            play.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.25),
            play.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            play.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
            ])
        
        play.addTarget(self, action: #selector(tappedPlay(_:)), for: .touchUpInside)
    }

    @objc func tappedPlay(_ sender: UIGestureRecognizer) {
        guard let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate),
         let window = appDelegate.window else {
            debugPrint("tappedPlay: Error, no App Delegate or window.")
            return
        }
        let boardViewController = BoardViewController()
        boardViewController.viewModel = BoardViewModel(for: Level.tutorial)

        window.rootViewController = boardViewController
        
//        self.navigationController.pushViewController(boardViewController, animated: true)
    }
}
