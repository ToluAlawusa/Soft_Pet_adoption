//
//  RuleModel.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 01/06/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import Foundation


struct RuleModel: Codable {
    let action: String
    let otherwise: String
    let targets: [String]
}
