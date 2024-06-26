//
//  MainViewController.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//

import UIKit
import CoreLocation

class MainViewController: BaseViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var highestTempLabel: UILabel!
    @IBOutlet weak var lowestTempLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    
    var viewModel: MainViewModel?
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setupViewModel()
        bindViewModel()
        self.view.showLoading()
    }
    
    func setupViewModel() {
        viewModel = MainViewModel()
    }
}

extension MainViewController {
    
    func bindViewModel() {
        viewModel?.output.onSuccessGetCurrentTemp = onSuccessGetCurrentTemp()
    }
    
    func onSuccessGetCurrentTemp() -> ((MainModel.NowcastViewModel) -> Void) {
        self.view.hideLoading()
        return { [weak self] nowcastData in
            self?.currentTempLabel.text = "\(nowcastData.currentTemp)°"
            self?.highestTempLabel.text = "H:\(nowcastData.highestTemp)°"
            self?.lowestTempLabel.text = "L:\(nowcastData.lowestTemp)°"
            self?.conditionLabel.text = nowcastData.condition
            self?.locationLabel.text = nowcastData.location
            self?.feelLikeLabel.text = "Feel Like:\(nowcastData.feelLike)°"
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
