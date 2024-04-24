//
//  MainModel.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 23/4/2567 BE.
//

import Foundation

enum MainModel {
    struct NowcastViewModel {
        let location: String
        let currentTemp: String
        let highestTemp: String
        let lowestTemp: String
        let condition: String
        let feelLike: String
        let forcastCurrent: [Hour]
    }
}
