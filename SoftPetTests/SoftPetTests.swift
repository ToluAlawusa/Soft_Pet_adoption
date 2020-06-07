//
//  SoftPetTests.swift
//  SoftPetTests
//
//  Created by Tolulope Alawusa on 30/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import XCTest
@testable import SoftPet

class SoftPetTests: XCTestCase {

  

    func testFormModel() {
        let formmodel = FormModel.self
        XCTAssertNotNil(formmodel)
    }
    
    func testPageModel() {
       let pagemodel = PageModel.self
       XCTAssertNotNil(pagemodel)
    }
    
    func testSectionModel() {
       let sectionmodel = SectionModel.self
       XCTAssertNotNil(sectionmodel)
    }
    
    func testElementModel() {
       let elementmodel = ElementModel.self
       XCTAssertNotNil(elementmodel)
    }
    
    func testRuleModel() {
       let rulemodel = RuleModel.self
       XCTAssertNotNil(rulemodel)
    }
    
 
    
//    func testExample() {
//           XCTAssertTrue(true)
//    }

}
