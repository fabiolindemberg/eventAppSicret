//
//  Event.swift
//  AppEventTest
//
//  Created by Fabio Lindemberg on 24/05/20.
//  Copyright © 2020 Fabio Lindemberg. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let event = try? newJSONDecoder().decode(Event.self, from: jsonData)

import Foundation

// MARK: - Event
struct Event: Codable {
    let people: [Person]
    let date: Int
    let welcomeDescription: String
    let image: String
    let longitude, latitude, price: Double
    let title, id: String
    let cupons: [Cupon]

    enum CodingKeys: String, CodingKey {
        case people, date
        case welcomeDescription = "description"
        case image, longitude, latitude, price, title, id, cupons
    }
}

// MARK: - Cupon
struct Cupon: Codable {
    let id, eventID: String
    let discount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case eventID = "eventId"
        case discount
    }
}

// MARK: - Person
struct Person: Codable {
    let id, eventID, name, picture: String

    enum CodingKeys: String, CodingKey {
        case id
        case eventID = "eventId"
        case name, picture
    }
}

typealias Welcome = [Event]
