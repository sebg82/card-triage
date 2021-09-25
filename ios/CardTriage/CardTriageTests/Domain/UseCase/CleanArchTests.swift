//
//  CleanArchTests.swift
//  CardTriageTests
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import XCTest
@testable import CardTriage

class CardsListUseCaseTests: XCTestCase {
    
    static let cardsEntityLists: [[CardEntity]] = {
        [
            [],
            [
                CardEntity(id: 1,
                           arrhythmias: [],
                           createdDate: Date(),
                           patientName: "Patient1",
                           status: .done)
            ],
            [
                CardEntity(id: 1,
                           arrhythmias: [],
                           createdDate: Date(),
                           patientName: "Patient1",
                           status: .done),
                CardEntity(id: 2,
                           arrhythmias: [.aFib],
                           createdDate: Date(),
                           patientName: "Patient2",
                           status: .pending)
            ]
        ]
    }()
    
    enum DataSourceErrorMock: Error {
        case empty(String)
    }
    
    class CardDataMock: CardDataInterface {
        
        var mockNumber: Int
        var success: Bool

        init(mockNumber:Int, success: Bool) {
            self.mockNumber = mockNumber
            self.success = success
        }
        
        func fetchCardsList(_ completion: @escaping (Result<[CardEntity], Error>) -> Void) {
            if success {
                completion(.success(cardsEntityLists[mockNumber]))
            } else {
                completion(.failure(DataSourceErrorMock.empty("")))
            }
        }
        
        func saveCardsList(_ cardsList: [CardEntity], completion: @escaping (Result<Bool, Error>) -> Void) {}
    }
    
    func testCardsListUseCase_whenSuccessfullyFetch() {
        // given
        let expectation = self.expectation(description: "Fetch Success")
        expectation.expectedFulfillmentCount = 1
        let mockNumberOK = 2
        let mockNumberKO = 1
        let cardData = CardDataMock(mockNumber: mockNumberOK, success: true)
        let useCase = CardsListUseCase(cardData)

        // when
        var cardsEntityListFetched: [CardEntity] = []
        useCase.fetch { result in
            switch result {
            case .success(let cards): cardsEntityListFetched = cards
            case .failure(_): break
            }
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(cardsEntityListFetched == Self.cardsEntityLists[mockNumberOK])
        XCTAssertFalse(cardsEntityListFetched == Self.cardsEntityLists[mockNumberKO])
    }
    
    func testCardsListUseCase_whenFailedFetch() {
        // given
        let expectation = self.expectation(description: "Fetch Fail")
        expectation.expectedFulfillmentCount = 1
        let mockNumber = 2
        let cardData = CardDataMock(mockNumber: mockNumber, success: false)
        let useCase = CardsListUseCase(cardData)

        // when
        var cardsEntityListFetched: [CardEntity] = []
        useCase.fetch { result in
            switch result {
            case .success(let cards): cardsEntityListFetched = cards
            case .failure(_): break
            }
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(cardsEntityListFetched == [])
    }
}
