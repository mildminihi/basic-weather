//
//  MainViewController.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    
    var viewModel: MainViewModel?
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setupViewModel()
        bindViewModel()
    }
    
    func setupViewModel() {
        viewModel = MainViewModel()
    }
}

extension MainViewController {
    
    func bindViewModel() {
        viewModel?.output.onSuccessGetCurrentTemp = onSuccessGetCurrentTemp()
    }
    
    func onSuccessGetCurrentTemp() -> ((Nowcast) -> Void) {
        return { [weak self] nowcastData in
            self?.currentTempLabel.text = "\(nowcastData.stateCode)°"
            self?.locationLabel.text = nowcastData.cityName
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            print("not autorize")
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        viewModel?.input.getCurrentTemp(lad: latitude, long: longitude)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
