//
//  RootViewController.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data
//        let url = URL(string: "https://github.com/sebg82/card-triage/raw/master/server/cards.json")!
//        let cardsData = CardDataRemote(url)
        let url = Bundle.main.url(forResource: "cards", withExtension: "json")!
        let cardsData = CardDataLocal(url)

        // Domain
        let fetchCardsList = CardsListUseCase(cardsData)

        // Presentation
        let cardsListViewModel = CardsListViewModel(fetchCardsList)
        let cardsListViewController = CardsListViewController(cardsListViewModel)
        navigationController?.pushViewController(cardsListViewController, animated: true)
    }
}

