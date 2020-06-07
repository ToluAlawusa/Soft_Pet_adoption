//
//  PageModel.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 01/06/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import Foundation

struct PageModel: Codable {
    let label: String
    let sections: [SectionModel]
}
