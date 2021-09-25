//
//  CardsListViewController+model.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import Foundation

extension CardsListViewController {
    
    func initModel() {
        
        // VM -> V
        cardsListViewModel.didChange = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // V -> VM
        cardsListViewModel.loadData()
    }
}
