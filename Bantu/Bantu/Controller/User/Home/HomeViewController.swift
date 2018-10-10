//
//  HomeViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 08/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var eventImages = [UIImage(named: "dummy"), UIImage(named: "dummy")]
    var eventTitles = ["1000 Guru Tangerang #TNT4", "1000 Guru Tangerang #TNT4"]
    var dates = ["10 - 11 September 2018", "12 - 13 September 2018"]
    var locations = ["Banten", "Jakarta"]
    
    

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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTitles.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        
        cell.eventImageView.image = eventImages[indexPath.row]
        cell.eventTitleLabel.text = eventTitles[indexPath.row]
        cell.dateLabel.text = dates[indexPath.row]
        cell.locationLabel.text = locations[indexPath.row]
    
        return cell
    }
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
