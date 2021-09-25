//
//  CardEntity.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

struct CardEntity: Equatable, Identifiable {
    
    let id: Int
    let arrhythmias: [Arrhythmias]
    let createdDate: Date
    let patientName: String
    let status: Status

    enum Arrhythmias: String, Codable {
        case aFib = "AFib"
        case avBlock = "AV Block"
        case pause = "Pause"
        case psvc = "PSVC"
        case pvc = "PVC"
    }

    enum Status: String, Codable, CaseIterable {
        case pending = "PENDING"
        case rejected = "REJECTED"
        case done = "DONE"
    }
}
