//
//  ProcessJson.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 02/06/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import Foundation
import UIKit

func reed() -> FormModel? {
    do {

        if let bundlePath = Bundle.main.path(forResource: "pet_adoption",
                                             ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            //return jsonData
            do {
                let decodedData = try JSONDecoder().decode(FormModel.self,
                                                               from: jsonData)
                print("PJ", decodedData.pages)
                    print("===================================")

                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(decodedData) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "saved_formmodel")
                }
                    return decodedData
                } catch {
                    print("decode error")
                }

        }
    } catch {
        print(error)
    }

    return nil
}

