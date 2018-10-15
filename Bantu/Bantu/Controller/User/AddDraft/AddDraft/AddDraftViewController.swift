//
//  AddDraftViewController.swift
//  Bantu
//
//  Created by Resky Javieri on 10/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class AddDraftViewController: UIViewController {
    
    
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var studentNoTextField: UITextField!
    @IBOutlet weak var teacherNo: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var needsCollectionView: UICollectionView!
    @IBOutlet weak var schoolCollectionView: UICollectionView!
    @IBOutlet weak var roadCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var isNewDraft: Bool!
    var currentDraft: Post!
    var isPickingSchool: Bool = false
    var isPickingRoad: Bool = false
    var isCurrentlyEditing: Bool = false
    
    let locationManager = CLLocationManager()
    var locationUpdateCounter: Int = 0
    var tempLocLatitude: Double = 0
    var tempLocLongitude: Double = 0
    var tempLocAOI: String = ""
    var tempLocAdminArea: String = ""
    var tempLocName: String = ""
    var tempLocLocality: String = ""
    
    
    var dummyNeeds: [Needs] = [
        Needs(needsId: 1, needsName: "Air"),
        Needs(needsId: 3, needsName: "Buku")
    ]
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View Loaded")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        self.setInitialLoad()
    }
    
    @IBAction func addSchoolImageButtonTapped(_ sender: Any) {
        self.isPickingSchool = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addRoadImageButtonTapped(_ sender: Any) {
        self.isPickingRoad = true
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func tapToShareButton(_ sender: Any) {
        self.setUpMap()
    }
    
    @objc func saveButtonTapped() {
        self.currentDraft.schoolName = self.schoolNameTextField.text!
        self.currentDraft.about = self.aboutTextField.text
        self.currentDraft.studentNo = Int(self.studentNoTextField.text!)!
        self.currentDraft.teacherNo = Int(self.teacherNo.text!)!
        self.currentDraft.access = self.accessTextView.text
        self.currentDraft.address = self.addressTextView.text
        self.currentDraft.notes = self.notesTextView.text
        
        self.currentDraft.locationLatitude = self.tempLocLatitude
        self.currentDraft.locationLongitude = self.tempLocLongitude
        self.currentDraft.locationAOI = self.tempLocAOI
        self.currentDraft.locationName = self.tempLocName
        self.currentDraft.locationLocality = self.tempLocLocality
        self.currentDraft.locationAdminArea = self.tempLocAdminArea
        
        self.isNewDraft = false
        self.saveNewDraftToCoreData()
            
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Clicked Anywhere")
        self.becomeFirstResponder()
    }
    
    
    func saveNewDraftToCoreData() {
        let tempPost = DraftEntity(context: LocalServices.context)
        tempPost.schoolName = self.currentDraft.schoolName
        tempPost.aboutPost = self.currentDraft.about
        tempPost.studentNo = Int64(self.currentDraft.studentNo)
        tempPost.teacherNo = Int64(self.currentDraft.teacherNo)
        tempPost.accessPost = self.currentDraft.access
        tempPost.addressPost = self.currentDraft.address
        tempPost.notesPost = self.currentDraft.notes
        tempPost.locationLatitude = self.currentDraft.locationLatitude
        tempPost.locationLongitude = self.currentDraft.locationLongitude
        
        
        tempPost.locationAOI = self.currentDraft.locationAOI
        tempPost.locationName = self.currentDraft.locationName
        tempPost.locationLocality = self.currentDraft.locationLocality
        tempPost.locationAdminArea = self.currentDraft.locationAdminArea
        
        var CDataArrayNeeds = NSMutableArray()
        var CDataArraySchool = NSMutableArray()
        var CDataArrayRoad = NSMutableArray()
        
        // Testing
        print(tempPost.schoolName!)
        print(tempPost.aboutPost!)
        print(tempPost.studentNo)
        print(tempPost.teacherNo)
        print(tempPost.accessPost!)
        print(tempPost.addressPost!)
        print(tempPost.notesPost!)
        print(tempPost.locationLatitude)
        print(tempPost.locationLongitude)
        print(tempPost.locationAOI!)
        print(tempPost.locationName!)
        print(tempPost.locationLocality!)
        print(tempPost.locationAdminArea!)
        
        for need in self.currentDraft.needs {
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: need)
            CDataArrayNeeds.add(data)
        }
        
        for img in self.currentDraft.schoolImages {
            let data: NSData = NSData(data: img.jpegData(compressionQuality: 1)!)
            CDataArraySchool.add(data)
        }
        
        for img in self.currentDraft.roadImages {
            let data: NSData = NSData(data: img.jpegData(compressionQuality: 1)!)
            CDataArrayRoad.add(data)
        }
        
        // Convert Array to NSData
        // Save in Core Data
        let coreDataObjectNeeds = NSKeyedArchiver.archivedData(withRootObject: CDataArrayNeeds)
        let coreDataObjectSchool = NSKeyedArchiver.archivedData(withRootObject: CDataArraySchool)
        let coreDataObjectRoad = NSKeyedArchiver.archivedData(withRootObject: CDataArrayRoad)
        
        
        tempPost.schoolImages = coreDataObjectSchool as NSData
        tempPost.roadImages = coreDataObjectRoad as NSData
        
        let currDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-mm-yyyy"
        let dateString = formatter.string(from: currDate)
        let dateDate: NSDate = formatter.date(from: dateString) as! NSDate
        
        tempPost.timeStamp = dateDate
        
        LocalServices.saveContext()
        
    }
    
    func deleteFromCoreData() {
        
        let managedContext = LocalServices.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DraftEntity> = DraftEntity.fetchRequest()
        
        do
        {
            let fetchData = try LocalServices.context.fetch(fetchRequest)
            let node = fetchData[0]
            managedContext.delete(node)
            
            do
            {
                try managedContext.save()
                print("Delete Success")
            } catch let error as NSError {
                print("Error deleting node : \(error.userInfo)")
            }
        }
        catch _ {
            print("Failed to delete")
        }
        
    }
    
    func setInitialLoad() {
        self.schoolNameTextField.text = self.currentDraft.schoolName
        self.aboutTextField.text = self.currentDraft.about
        self.accessTextView.text = self.currentDraft.access
        self.addressTextView.text = self.currentDraft.address
        self.notesTextView.text = self.currentDraft.notes
        
        if (self.currentDraft.locationLatitude != 0 && self.currentDraft.locationLongitude != 0) {
            let tempLoc = CLLocation(latitude: self.currentDraft.locationLatitude, longitude: self.currentDraft.locationLongitude)
            self.setLocationOnMap(userLocation: tempLoc)
        }
        
        
    }
    
    func setUpMap() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
}


extension AddDraftViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.needsCollectionView) {
            if (self.currentDraft.needs.count == 0) {
                return 0
            } else {
                return self.currentDraft.needs.count
            }
        }
        else if (collectionView == self.schoolCollectionView) {
            if (self.currentDraft.schoolImages.count == 0) {
                return 0
            } else {
                return self.currentDraft.schoolImages.count
            }
        }
        else {
            if (self.currentDraft.roadImages.count == 0) {
                return 0
            } else {
                return self.currentDraft.roadImages.count
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.needsCollectionView) {
            let cell = self.needsCollectionView.dequeueReusableCell(withReuseIdentifier: "needsCell", for: indexPath) as! needsCollectionCell
            cell.needsCollection.text = "\(self.currentDraft.needs[indexPath.row].needsName)"
            return cell
        }
        
        if (collectionView == self.schoolCollectionView) {
            let cell = self.schoolCollectionView.dequeueReusableCell(withReuseIdentifier: "schoolCell", for: indexPath) as! imagesCollectionCell
            cell.setImages(image: self.currentDraft.schoolImages[indexPath.row])
            return cell
        }
        
        let cell = self.roadCollectionView.dequeueReusableCell(withReuseIdentifier: "roadCell", for: indexPath) as! imagesCollectionCell
        cell.setImages(image: self.currentDraft.roadImages[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var footerIdentifier: String = ""
        
        if (collectionView == self.schoolCollectionView) {
            footerIdentifier = "schoolFooter"
        }
        else if (collectionView == self.roadCollectionView) {
            footerIdentifier = "roadFooter"
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath)
        return footerView
        
    }
    
}


extension AddDraftViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            
            if (self.isPickingSchool == true) {
                self.isPickingSchool = false
                self.currentDraft.schoolImages.append(image)
                let indexPath = IndexPath(row: self.currentDraft.schoolImages.count-1, section: 0)
                self.schoolCollectionView.insertItems(at: [indexPath])
            }
            else {
                self.isPickingRoad = false
                self.currentDraft.roadImages.append(image)
                let indexPath = IndexPath(row: self.currentDraft.roadImages.count-1, section: 0)
                self.roadCollectionView.insertItems(at: [indexPath])
            }
        }
    }
}


extension AddDraftViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        self.setLocationOnMap(userLocation: userLocation)
        
        self.tempLocLatitude = userLocation.coordinate.latitude
        self.tempLocLongitude = userLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            if self.locationUpdateCounter == 0
            {
                if (error != nil)
                {
                    // If Offline
                }
                else
                {
                    // If Online
                    if let place = placemark?[0]
                    {
                        self.tempLocLocality = place.locality!
                        self.tempLocAOI = place.areasOfInterest![0]
                        self.tempLocName = place.name!
                        self.tempLocAdminArea = place.administrativeArea!
                    }
                    else
                    {
                        // Failed pinpoint location
                    }
                }
                self.locationUpdateCounter += 1
            }
            else
            {
                self.locationManager.stopUpdatingLocation()
                self.locationUpdateCounter = 0
            }
        }
    }
    
    
    
    func setLocationOnMap(userLocation: CLLocation) {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        self.mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    

}

extension AddDraftViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.schoolNameTextField.resignFirstResponder()
        return true
    }
}
