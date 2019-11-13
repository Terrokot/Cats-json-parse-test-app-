//
//  JsonDataModel.swift
//  Cats
//
//  Created by Egor Tereshonok on 11/12/19.
//  Copyright © 2019 Egor Tereshonok. All rights reserved.
//

import Foundation

struct Cats: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let imageUrl: String?
}
