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
        tableView.register(UINib(nibName: CardsListItemCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CardsListItemCell.reuseIdentifier)
        
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

extension CardsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardsListItemCell.reuseIdentifier, for: indexPath) as! CardsListItemCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CardsListItemCell.height
    }
}
