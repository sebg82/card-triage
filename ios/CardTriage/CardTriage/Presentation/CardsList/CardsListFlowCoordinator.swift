//
//  CardsListFlowCoordinator.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

protocol CardsListFlowCoordinator  {
    func makeCardsListViewController() -> CardsListViewController
}

final class CardsListCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let coordinator: CardsListFlowCoordinator

    init(navigationController: UINavigationController, coordinator: CardsListFlowCoordinator) {
        self.navigationController = navigationController
        self.coordinator = coordinator
    }
    
    func show() {
        let vc = coordinator.makeCardsListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
