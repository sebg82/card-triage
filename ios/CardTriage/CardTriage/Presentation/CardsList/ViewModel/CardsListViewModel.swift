//
//  CardsListViewModel.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardsListViewModel {
    
    private let cardsListUseCase: CardsListUseCase
    var sectionsOriginal: [CardsListSectionModel] = []
    var sections: [CardsListSectionModel] = []
    var didChange: () -> () = { }
    
    init(_ cardsListUseCase: CardsListUseCase) {
        self.cardsListUseCase = cardsListUseCase
    }
    
    func loadData() {
        cardsListUseCase.fetch { result in
            switch result {
            case .success(let cardsList):
                let flatCardsList = cardsList.compactMap{CardsListItemModel($0)}
                self.sectionsOriginal = self.cardsListUseCase.getAllStatus().map { status in
                    CardsListSectionModel(status: status.rawValue, cards: flatCardsList.filter { $0.status == status.rawValue })
                }
                self.didChange()
            case .failure(let error):
                print(error)
            }
        }
    }
}
