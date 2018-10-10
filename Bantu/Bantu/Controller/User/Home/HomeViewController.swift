//
//  HomeViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
    }
    
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"user-4"), style: .plain, target: self, action: #selector(profileTapped))
    }
    
    @objc func profileTapped() {
        performSegue(withIdentifier: "homeToLog", sender: nil)
    }
}

