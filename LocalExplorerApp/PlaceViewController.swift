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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
