//
//  ElementModel.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 01/06/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import Foundation

struct ElementModel: Codable {
    let type: ElementType
    let rules: [RuleModel]?
    let uniqueId: String
    let file: String?
    let label: String?
    let isMandatory: Bool?
    let keyboard: KeyboardType?
    let formattedNumeric: String?
    let mode: Mode?
    let options: [String]?
    
    enum CodingKeys: String, CodingKey {
        case type, file, uniqueId="unique_id", rules, label, isMandatory, keyboard, formattedNumeric, mode, options
    }
}


enum ElementType: String, Codable {
    case embeddedPhoto = "embeddedphoto"
    case text
    case yesNo = "yesno"
    case formattedNumeric = "formattednumeric"
    case dateTime = "datetime"
}


enum KeyboardType: String, Codable {
    case numeric
    case email
    case normal
    case password
}


enum Mode: String, Codable {
    case date
    case select
}






