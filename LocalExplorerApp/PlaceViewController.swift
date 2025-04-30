//
//  PlaceViewController.swift
//  LocalExplorerApp
//
//  Created by Ricardo Ortega on 4/29/25.
//

import UIKit
import CoreData
import CoreLocation


class PlaceViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    var currentPhoto: Photo?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sgmtEditMode: UISegmentedControl!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var picChange: UIButton!
    @IBOutlet weak var photoName: UITextField!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLong: UILabel!
    
    
    lazy var geoCoder = CLGeocoder()
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // ask for the user's location 
        locationManager.requestWhenInUseAuthorization()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - View/Edit Seg
    
    @IBAction func chngeEditMode(_ sender: Any) {
        let textFields: [UITextField] = [photoName]
        
        if sgmtEditMode.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            picChange.isHidden = true
            navigationItem.rightBarButtonItem = nil
        } else if sgmtEditMode.selectedSegmentIndex == 1 {
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            picChange.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                target: self,
                                                                action: #selector(self.savePhoto))
        }
    }
    // MARK: - Save
    
    @objc func savePhoto() {
       // appDelegate.saveContext()
        sgmtEditMode.selectedSegmentIndex = 0
        print("Photo saved!")
        chngeEditMode(self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Take Picture
    
    @IBAction func takePic(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraController = UIImagePickerController()
            cameraController.sourceType = .camera
            cameraController.cameraCaptureMode = .photo
            cameraController.delegate = self
            cameraController.allowsEditing = true
            self.present(cameraController, animated: true, completion: nil)
        }
    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[.editedImage] as? UIImage {
                    img.contentMode = .scaleAspectFit
                    img.image = image

                    
            }
           
            dismiss(animated: true, completion: nil)
        }
    
    // MARK: - Grab the coordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            _ = location.timestamp
            let howRecent = location.timestamp.timeIntervalSinceNow
            
            if Double(howRecent) < 15.0 {
                let coordinate = location.coordinate
                lblLat.text = String(format: "%.2f\u{00B0}")
                lblLong.text = String(format: "%.2f\u{00B0}")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("Permission granted")
        } else {
            print("Permission denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorType = error._code == CLError.denied.rawValue ? "access denied" : "unknown error"
        let alertController = UIAlertController(title: "Error Getting Location: \(errorType)",
                                                message: "Error Message: \(error.localizedDescription)",
                                                preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "OK",
                                style: .default,
                                     handler: nil)
        alertController.addAction(actionOK)
        present(alertController, animated: true, completion: nil)
            
        }
}
