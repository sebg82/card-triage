//
//  CardsListViewModel.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

final class CardsListViewModel {
    
    private let cardsListUseCase: CardsListUseCase
    private var sectionsOriginal: [CardsListSectionModel] = []
    var sections: [CardsListSectionModel] = []
    var filter: String = ""
    var didChange: () -> () = { }
    
    init(_ cardsListUseCase: CardsListUseCase) {
        self.cardsListUseCase = cardsListUseCase
    }
    
    func loadData() {
        cardsListUseCase.fetch { result in
            switch result {
            case .success(let cardsList):
                let flatCardsList = cardsList.compactMap{CardsListItemModel($0)}
                self.sectionsOriginal = self.cardsListUseCase.getAllStatus().map { status in
                    CardsListSectionModel(status: status.rawValue, cards: flatCardsList.filter { $0.status == status.rawValue })
                }
                self.updateSections()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filter(with text: String) {
        filter = text.lowercased()
        updateSections()
    }
    
    private func updateSections() {
        var filteredSections = self.sectionsOriginal
        if !filter.isEmpty {
            filteredSections = filteredSections.map { section in
                let filteredCard = section.cards.filter {
                    $0.arrhythmias.lowercased().contains(filter) ||
                    $0.patientName.lowercased().contains(filter)
                }
                return CardsListSectionModel(status: section.status, cards: filteredCard)
            }
        }
        sections = filteredSections
        didChange()
    }
}
