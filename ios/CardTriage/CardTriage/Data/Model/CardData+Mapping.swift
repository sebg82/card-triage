//
//  CardData+Mapping.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

extension CardData {
    
    init(cardEntity: CardEntity) {
        self.init(id: cardEntity.id,
                  arrhythmias: cardEntity.arrhythmias.compactMap { Arrhythmias($0) },
                  createdDate: ISO8601DateFormatter().string(from: cardEntity.createdDate),
                  patientName: cardEntity.patientName,
                  status: Status(cardEntity.status)!)
    }

    func toDomain() -> CardEntity {
        return CardEntity(id: id,
                           arrhythmias: arrhythmias.compactMap { $0.toDomain() },
                           createdDate: ISO8601DateFormatter().date(from: createdDate)!,
                           patientName: patientName,
                           status: status.toDomain()!)
    }
}

extension CardData.Arrhythmias {
    
    init?(_ cardEntityArrhythmias: CardEntity.Arrhythmias?) {
        self.init(rawValue: cardEntityArrhythmias?.rawValue ?? "")
    }
    
    func toDomain() -> CardEntity.Arrhythmias? {
        guard let arrhythmias = CardEntity.Arrhythmias(rawValue: rawValue) else {
            print("cannot convert CardData.Arrhythmias '\(rawValue)' to CardEntity.Arrhythmias")
            return nil
        }
        return arrhythmias
    }
}

extension CardData.Status {
    
    init?(_ cardEntityStatus: CardEntity.Status?) {
        self.init(rawValue: cardEntityStatus?.rawValue ?? "")
    }
    
    func toDomain() -> CardEntity.Status? {
        guard let status = CardEntity.Status(rawValue: rawValue) else {
            print("cannot convert CardData.Status '\(rawValue)' to CardEntity.Status")
            return nil
        }
        return status
    }
}
