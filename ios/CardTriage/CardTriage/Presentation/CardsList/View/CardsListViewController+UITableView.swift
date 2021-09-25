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
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
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

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if !cardsListViewModel.move(rowAt: sourceIndexPath, to: destinationIndexPath) {
            let dialog = UIAlertController(title:"", message:"Can not move to this section", preferredStyle: .alert)
            let okAction = UIAlertAction(title:"OK", style: .default)
            dialog.addAction(okAction)
            self.present(dialog, animated:true, completion:nil)
        }
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        guard cardsListViewModel.canMove(from: sourceIndexPath.section, to: proposedDestinationIndexPath.section)
        else { return sourceIndexPath }
        return proposedDestinationIndexPath
    }
}

extension CardsListViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = cardsListViewModel.sections[indexPath.section].cards[indexPath.row]
        return [ dragItem ]
    }
}

extension CardsListViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {}
}
