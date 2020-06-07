//
//  SectionModel.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 01/06/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import Foundation

struct SectionModel: Codable {
    let label: String
    let elements: [ElementModel]
}
