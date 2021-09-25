//
//  CardData.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

struct CardData: Codable {
    
    let id: Int
    let arrhythmias: [Arrhythmias]
    let createdDate: String
    let patientName: String
    let status: Status

    private enum CodingKeys: String, CodingKey {
        case id
        case arrhythmias
        case createdDate = "created_date"
        case patientName = "patient_name"
        case status
    }

    enum Arrhythmias: String, Codable {
        case aFib = "AFib"
        case avBlock = "AV Block"
        case pause = "Pause"
        case psvc = "PSVC"
        case pvc = "PVC"
    }

    enum Status: String, Codable {
        case pending = "PENDING"
        case rejected = "REJECTED"
        case done = "DONE"
    }
}

extension CardData {
    
    func toDomain() -> CardEntity {
        return CardEntity(id: id,
                           arrhythmias: arrhythmias.compactMap { $0.toDomain() },
                           createdDate: ISO8601DateFormatter().date(from: createdDate)!,
                           patientName: patientName,
                           status: status.toDomain()!)
    }
}

extension CardData.Arrhythmias {

    func toDomain() -> CardEntity.Arrhythmias? {
        guard let arrhythmias = CardEntity.Arrhythmias(rawValue: rawValue) else {
            print("cannot convert CardData.Arrhythmias '\(rawValue)' to CardEntity.Arrhythmias")
            return nil
        }
        return arrhythmias
    }
}

extension CardData.Status {

    func toDomain() -> CardEntity.Status? {
        guard let status = CardEntity.Status(rawValue: rawValue) else {
            print("cannot convert CardData.Status '\(rawValue)' to CardEntity.Status")
            return nil
        }
        return status
    }
}
