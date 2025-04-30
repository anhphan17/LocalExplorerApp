//
//  PlaceViewController.swift
//  LocalExplorerApp
//
//  Created by Ricardo Ortega on 4/29/25.
//

import UIKit
import CoreData
import CoreLocation


class PlaceViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
}
