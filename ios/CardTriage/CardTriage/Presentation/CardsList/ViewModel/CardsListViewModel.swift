//
//  CardsListViewModel.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardsListViewModel {
    
    private let cardsListUseCase: CardsListUseCase
    var didChange: () -> () = { }
    
    init(_ cardsListUseCase: CardsListUseCase) {
        self.cardsListUseCase = cardsListUseCase
    }
    
    func loadData() {
        cardsListUseCase.fetch { result in
            switch result {
            case .success(let cardsList):
                print(cardsList)
                self.didChange()
            case .failure(let error):
                print(error)
            }
        }
    }
}
