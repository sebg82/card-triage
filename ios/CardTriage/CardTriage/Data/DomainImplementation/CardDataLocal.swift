//
//  CardDataLocal.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardDataLocal {

    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
}

extension CardDataLocal: CardDataInterface {

    func fetchCardsList(_ completion: @escaping (Result<[CardEntity], Error>) -> Void) {
        do {
            let data = try Data(contentsOf: url)
            let cardsList = try JSONDecoder().decode([CardData].self, from: data)
            let cardsEntityList = cardsList.compactMap { $0.toDomain() }
            completion(.success(cardsEntityList))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveCardsList(_ cardsList: [CardEntity], completion: @escaping (Result<Bool, Error>) -> Void) {
        
    }
}
