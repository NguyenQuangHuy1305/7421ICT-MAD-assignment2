//
//  SunriseSunsetViewModel.swift
//  Assignment2
//
//  Created by Nguyen Quang Huy on 1/6/2022.
//

import Foundation

/// this is the struct to store only what I need (sunrise sunset as strings)
struct SunriseSunset: Codable {
    var sunrise: String
    var sunset: String
}

/// this is a struct to store all data I got from the API
struct SunriseSunsetAPI: Codable {
    var results: SunriseSunset
    var status: String?
}
