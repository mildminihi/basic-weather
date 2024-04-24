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
        let endPoint = "https://weatherapi-com.p.rapidapi.com/forecast.json"
        let parameter: [String: Any] = ["q": "\(lad),\(long)", "day": "10"]
        Rest.shared.request(endPoint, parameters: parameter) { (result: Result<Nowcast, ResponseError>) in
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
        let forecastCurrent = model.forecast.forecastday.first?.hour ?? []
        let viewModel = MainModel.NowcastViewModel(
            location: model.location.name,
            currentTemp: String(model.current.tempC),
            highestTemp: String(forecastCurrent.map{$0.tempC}.max() ?? 0.0),
            lowestTemp: String(forecastCurrent.map{$0.tempC}.min() ?? 0.0),
            condition: model.current.condition.text.rawValue,
            feelLike: String(model.current.feelslikeC),
            forcastCurrent: forecastCurrent
        )
        self.onSuccessGetCurrentTemp?(viewModel)
    }
}
