//
//  CardsListUseCase.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardsListUseCase {

    private let cardData: CardDataInterface

    init(_ cardData: CardDataInterface) {
        self.cardData = cardData
    }
    
    func fetch(_ completion: @escaping (Result<[CardEntity], Error>) -> Void) {
        cardData.fetchCardsList(completion)
    }
    
    func save(_ cardsList: [CardEntity], completion: @escaping (Result<Bool, Error>) -> Void) {
        cardData.saveCardsList(cardsList, completion: completion)
    }
}
