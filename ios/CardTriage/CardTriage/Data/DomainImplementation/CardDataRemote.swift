//
//  CardDataRemote.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardDataRemote {

    let url: URL
    
    init(_ url: URL) {
        self.url = url
    }
}

extension CardDataRemote: CardDataInterface {
    
    enum DataSourceError: Error {
        case empty(String)
    }
    
    func fetchCardsList(_ completion: @escaping (Result<[CardEntity], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else {
                return completion(.failure(DataSourceError.empty("data")))
            }
            do {
                let cardsList = try JSONDecoder().decode([CardData].self, from: data)
                let cardsEntityList = cardsList.compactMap { $0.toDomain() }
                completion(.success(cardsEntityList))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func saveCardsList(_ cardsList: [CardEntity], completion: @escaping (Result<Bool, Error>) -> Void) {
        
    }
}
