//
//  RootViewController.swift
//  CardTriage
//
//  Created by Sebastien Gohier on 25/09/2021.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController!)
        AppDelegate.appFlowCoordinator?.start()
    }
}
