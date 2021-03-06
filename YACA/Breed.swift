//
//  Breed.swift
//  YACA
//
//  Created by Dmitry Reshetnik on 02.05.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

struct Breed: Codable {
    let id: String
    let name: String
    let temperament: String
    let lifeSpan: String
    let altNames: String?
    let wikipediaUrl: String?
    let description: String
    let origin: String
    let weight: [String: String]
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let hypoallergenic: Int
    let adaptability: Int
    let affectionLevel: Int
    let countryCode: String
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
}
