//
//  Nowcast.swift
//  basic-weather
//
//  Created by Supanat Wanroj on 22/4/2567 BE.
//
//   let nowcast = try? JSONDecoder().decode(Nowcast.self, from: jsonData)

import Foundation

// MARK: - Nowcast
struct Nowcast: Codable {
    let cityName, countryCode: String
    let data: [TempData]
    let lat, lon: Double
    let stateCode, timezone: String

    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case countryCode = "country_code"
        case data, lat, lon
        case stateCode = "state_code"
        case timezone
    }
}

// MARK: - TempData
struct TempData: Codable {
    let precip, snow: Int
    let temp: Double
    let timestampLocal, timestampUTC: String
    let ts: Int

    enum CodingKeys: String, CodingKey {
        case precip, snow, temp
        case timestampLocal = "timestamp_local"
        case timestampUTC = "timestamp_utc"
        case ts
    }
}
