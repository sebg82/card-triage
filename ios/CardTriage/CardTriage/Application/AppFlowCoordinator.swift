//
//  AppFlowCoordinator.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        CardsListCoordinator(navigationController: navigationController, coordinator: self).show()
    }
}

extension AppFlowCoordinator: CardsListFlowCoordinator {
    
    func makeCardsListViewController() -> CardsListViewController {
        // Data
//        let url = URL(string: "https://github.com/CardioLogs/card-triage/raw/master/server/cards.json")!
//        let cardsData = CardDataRemote(url)
        let url = Bundle.main.url(forResource: "cards", withExtension: "json")!
        let cardsData = CardDataLocal(url)

        // Domain
        let fetchCardsList = CardsListUseCase(cardsData)

        // Presentation
        let cardsListViewModel = CardsListViewModel(fetchCardsList)
        let cardsListViewController = CardsListViewController(cardsListViewModel)
        
        return cardsListViewController
    }
}
