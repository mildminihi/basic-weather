//
//  MainViewModel.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//
import Foundation

protocol MainViewModelInput {
    func getCurrentTemp(lad: Double, long: Double)
}

protocol MainViewModelOutput: AnyObject {
    var didError: (() -> Void)? { get set }
    var onSuccessGetCurrentTemp: ((Nowcast) -> Void)? { get set }
}

protocol MainViewModelInterface: MainViewModelInput, MainViewModelOutput {
    var input: MainViewModelInput { get }
    var output: MainViewModelOutput { get }
}

class MainViewModel: MainViewModelInterface {
    var input: MainViewModelInput { return self }
    var output: MainViewModelOutput { return self }
    
    func getCurrentTemp(lad: Double, long: Double) {
        print(lad, long)
        let endPoint = "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/minutely?lat=\(lad)&lon=\(long)"
        Rest.shared.request(endPoint) { (result: Result<Nowcast, ResponseError>) in
            switch result {
            case .success(let result):
                print(result)
                self.onSuccessGetCurrentTemp?(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var didError: (() -> Void)?
    var onSuccessGetCurrentTemp: ((Nowcast) -> Void)?
}
