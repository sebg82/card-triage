//
//  CardDataInterface.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

protocol CardDataInterface {

    func fetchCardsList(_ completion: @escaping (Result<[CardEntity], Error>) -> Void)
    func saveCardsList(_ cardsList: [CardEntity], completion: @escaping (Result<Bool, Error>) -> Void)
}
