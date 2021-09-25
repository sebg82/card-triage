//
//  CardsListItemCell.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

final class CardsListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CardsListItemCell.self)
    static let height = CGFloat(130)
    
    @IBOutlet private var patientName: UILabel!
    @IBOutlet private var status: UILabel!
    @IBOutlet private var createdDate: UILabel!
    @IBOutlet private var arrhythmias: UILabel!

    private var viewModel: CardsListItemModel!

    func fill(with viewModel: CardsListItemModel) {
        self.viewModel = viewModel
        arrhythmias.text = viewModel.arrhythmias
        createdDate.text = viewModel.createdDate
        patientName.text = viewModel.patientName
        status.text = viewModel.status
    }
}
