//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Jacob Jiang on 2/22/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).otherElements["avatarCollectionViewCell"].tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).otherElements["avatarCollectionViewCell"].tap()
        
        let avatarcollectionviewcellElement = collectionViewsQuery.children(matching: .cell).element(boundBy: 3).otherElements["avatarCollectionViewCell"]
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        avatarcollectionviewcellElement.tap()
        
        XCTAssert(app.tables/*@START_MENU_TOKEN@*/.staticTexts["Wanda Howard"]/*[[".cells.staticTexts[\"Wanda Howard\"]",".staticTexts[\"Wanda Howard\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
                
    }

}
