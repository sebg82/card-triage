//
//  CardsListItemModel.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

struct CardsListSectionModel {
    var status: String
    var cards: [CardsListItemModel]
}

struct CardsListItemModel {

    let arrhythmias: String
    let createdDate: String
    let patientName: String
    var status: String
}

extension CardsListItemModel {

    init(_ cardEntity: CardEntity) {
        self.arrhythmias = cardEntity.arrhythmias.map{$0.rawValue}.joined(separator: ", ")
        self.createdDate = dateFormatter.string(from: cardEntity.createdDate)
        self.patientName = cardEntity.patientName
        self.status = cardEntity.status.rawValue 
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
