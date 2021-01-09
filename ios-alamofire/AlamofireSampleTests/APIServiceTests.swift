//
//  APIServiceTest.swift
//  AlamofireSample
//
//  Created by Natthawut Haematulin on 15/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import XCTest
@testable import AlamofireSample

class APIServiceTests: XCTestCase {
    
    var service: APIService? = nil
    override func setUp() {
        super.setUp()
        service = APIService(baseURL: "https://api.github.com")
    }
    
    override func  tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testBuildURL() {
        let endpoint = "users"
        let actualURL = service?.buildURL(endpoint: endpoint)
        XCTAssertEqual("https://api.github.com/users", actualURL)
    }
    
    func testGet() {
        let expect = expectation(description:"GET")
        var actualResult: Repo?
        
        service?.get(endpoint: "repos/nuxzero/android-architecture", type: Repo.self, success: { (result: Repo?) in
            actualResult = result 
            expect.fulfill()
        }, failure: { error in
            XCTFail(error.localizedDescription)
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(actualResult)
        XCTAssertEqual(91595643, actualResult?.id)
        XCTAssertEqual("android-architecture", actualResult?.name)
    }
    
    
    func testGetList() {
        let expect = expectation(description:"GET")
        var actualResult: [Repo]?
        
        service?.get(endpoint: "users/nuxzero/repos", type: [Repo].self, success: { (result: [Repo]?) in
            actualResult = result
            expect.fulfill()
        }, failure: { error in
            XCTFail(error.localizedDescription)
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(actualResult)
        XCTAssertEqual(30, actualResult?.count)
    }
    
    /**
     * Ignored: This test code it's work fine but API response incorrect format.
     * Todo: Find another API to test post request.
     */
    func testPostRepoToHttpbin() {
        let expect = expectation(description:"POST")
        var actualResult: Httpbin?
        let s = APIService(baseURL: "https://httpbin.org")
    
        let repo = Repo(id: 123, name: "Alamofire")
        s.post(endpoint: "post",
               type: Httpbin.self,
               body: repo,
               success: { (result: Httpbin?) in
                    actualResult = result
                    expect.fulfill()
                },
               failure: { (error: Error) in
                    XCTFail(error.localizedDescription)
                    expect.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(actualResult)
        XCTAssertEqual(123, actualResult!.form.id)
    }
    
    func testToDictionaryFromCodableObject() {
        let repo = Repo(id: 1234, name: "Alamofire")
        
        let actualDictionary = try! service?.toDictionary(from: repo)
        
        XCTAssertNotNil(actualDictionary)
        XCTAssertEqual(1234, actualDictionary!["id"] as! Int)
        XCTAssertEqual("Alamofire", actualDictionary!["name"] as? String)
    }
}
