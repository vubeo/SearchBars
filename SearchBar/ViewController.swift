//
//  ViewController.swift
//  SearchBar
//
//  Created by Đỗ Hoàng Vũ on 7/9/18.
//  Copyright © 2018 Đỗ Hoàng Vũ. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class ViewController: UIViewController, UISearchBarDelegate, LocateOnTheMap {
    

    
    @IBOutlet weak var my_view: UIView!
    var googleMapView : GMSMapView!
    var searchResultController : SearchResultsController!
    var resultsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.googleMapView = GMSMapView(frame: self.my_view.frame)
        self.view.addSubview(self.googleMapView)
     //  searchResultController = searchResultController()
   //     searchResultController.delegate = self
        
    }

    
    /**
     action for search location by address
     - parameter sender : button search location
 */
    @IBAction func Search_Btn(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion: nil)
      }
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        DispatchQueue.main.async {
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withLatitude: lat
                , longitude: lon, zoom: 10)
            marker.title = "addrees : \(title)"
            self.googleMapView.camera = camera
            marker.map = self.googleMapView
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let placeClient = GMSPlacesClient()
        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error) in
            self.resultsArray.removeAll()
            if results == nil {
                return
            }
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    self.resultsArray.append(result.attributedFullText.string)
                }
            }
            self.searchResultController.reloadDataWithArray(self.resultsArray)
            
        }
    }
}










































