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
    var onSuccessGetCurrentTemp: ((MainModel.NowcastViewModel) -> Void)? { get set }
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
        let endPoint = "https://weatherapi-com.p.rapidapi.com/current.json?q=\(lad)%2C\(long)"
        Rest.shared.request(endPoint) { (result: Result<Nowcast, ResponseError>) in
            switch result {
            case .success(let result):
                print(result)
                self.onGetCurrentTempSuccess(model: result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var didError: (() -> Void)?
    var onSuccessGetCurrentTemp: ((MainModel.NowcastViewModel) -> Void)?
    
    private func onGetCurrentTempSuccess(model: Nowcast) {
//        let tempList: [Double] = model.data.map {$0.temp}
        let viewModel = MainModel.NowcastViewModel(
            location: model.location.name,
            currentTemp: String(model.current.tempC),
            highestTemp: String(0.0),
            lowestTemp: String(0.0)
        )
        self.onSuccessGetCurrentTemp?(viewModel)
    }
}
