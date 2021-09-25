//
//  CardsListViewModel.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardsListViewModel {
    
    private let cardsListUseCase: CardsListUseCase
    
    init(_ cardsListUseCase: CardsListUseCase) {
        self.cardsListUseCase = cardsListUseCase
    }
}
