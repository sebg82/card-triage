//
//  CardsListViewController+UITableView.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

extension CardsListViewController {

    func initTableview() {
        tableView.register(UINib(nibName: CardsListItemCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CardsListItemCell.reuseIdentifier)
    }
}

extension CardsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cardsListViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cardsListViewModel.sections[section].status
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsListViewModel.sections[section].cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardsListItemCell.reuseIdentifier, for: indexPath) as! CardsListItemCell
        cell.fill(with: cardsListViewModel.sections[indexPath.section].cards[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CardsListItemCell.height
    }
}
