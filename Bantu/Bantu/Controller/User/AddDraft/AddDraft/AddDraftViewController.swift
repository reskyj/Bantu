//
//  AddDraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class AddDraftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(postButtonTapped))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
    }
    
    @objc func postButtonTapped() {
        
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
