//
//  DefaultViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import CoreData

class DefaultViewController: UIViewController {
    
    var isNewDraft: Bool = false
    var currentDraft: Post!
    
    var draftArray: [Post] = []
    var tempResult: [DraftEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Loaded on defaultviewcontroller")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (AddDraft.onDraft == false){
            AddDraft.onDraft = true
//            performSegue(withIdentifier: "toAddDraftView", sender: nil)
        }
        else{
            AddDraft.onDraft = false
            self.tabBarController?.selectedIndex = AddDraft.selectedIndex
        }
    }
    
    @IBAction func addDraftButton(_ sender: Any) {
        print("Add New Draft")
        self.createNewDraft()
    }
    
    func createNewDraft() {
        self.isNewDraft = true
        performSegue(withIdentifier: "toAddDraftView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddDraftView" {
            let destination = segue.destination as! AddDraftViewController
            
//            let destination = segue.destination as! AddDraftViewController
            destination.isNewDraft = self.isNewDraft
            
            if (self.isNewDraft == true) {
                self.currentDraft = Post(postId: 0, userId: 0, statusId: 0, timeStamp: "", schoolName: "", about: "", studentNo: 0, teacherNo: 0, address: "", access: "", notes: "", locationAOI: "", locationName: "", locationLocality: "", locationAdminArea: "", locationLatitude: 0, locationLongitude: 0, schoolImages: [], roadImages: [], needs: [])
            }
            destination.currentDraft = self.currentDraft
        }
    }
    
    
}
