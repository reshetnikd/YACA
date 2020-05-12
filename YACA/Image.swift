//
//  Image.swift
//  YACA
//
//  Created by Dmitry Reshetnik on 02.05.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation

struct Image: Codable {
    let id: String
    let url: String
    let breeds: [Breed]
}
