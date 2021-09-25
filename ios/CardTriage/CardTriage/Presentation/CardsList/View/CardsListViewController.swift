//
//  CardsListViewController.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

final class CardsListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var cardsListViewModel: CardsListViewModel!
    
    init(_ cardsListViewModel: CardsListViewModel) {
        self.cardsListViewModel = cardsListViewModel
        super.init(nibName: "CardsListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Patients"
        navigationItem.setHidesBackButton(true, animated: false)
        initTableview()
        initModel()
    }
}
