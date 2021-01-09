//
//  StorageTest.swift
//  RealmSampleTests
//
//  Created by Nux on 14/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RealmSample

class StorageTest: XCTestCase {
    
    var storage: Storage? = nil
    
    override func setUp() {
        let config = Realm.Configuration(inMemoryIdentifier: "realm.sample.test.storage")
        storage = Storage(configuration: config)
    }
    
    override func tearDown() {
        
    }
    
    func testSaveSingle() {
        let account = Account()
        account.username = "john"
        account.email = "john@mail.com"
        
        storage?.saveSingle(account)
        
        let actualAccount = storage?.loadSingle(Account.self)
        XCTAssertEqual("john", actualAccount!.username)
    }
}
