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
