//
//  SunriseSunsetViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 1/6/2022.
//

import Foundation

struct SunriseSunset: Codable {
    var sunrise: String
    var sunset: String
}

struct SunriseSunsetAPI: Codable {
    var results: SunriseSunset
    var status: String?
}
