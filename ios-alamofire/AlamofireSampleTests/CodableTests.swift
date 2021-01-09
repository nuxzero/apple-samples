//
//  CodableTests.swift
//  AlamofireSampleTests
//
//  Created by Natthawut Haematulin on 15/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import XCTest
@testable import AlamofireSample

class CodableTests: XCTestCase {
    
    private func getFilePath(fileName: String, ofType: String) -> URL {
        let stringPath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: ofType)
        return URL(fileURLWithPath: stringPath!)
    }
    
    func testDecodeRepo() {
        let repoData = try! Data(contentsOf: self.getFilePath(fileName: "get-repo", ofType: "json"), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        
        let repo = try! decoder.decode(Repo.self, from: repoData)
        
        XCTAssertNotNil(repo)
        XCTAssertEqual(91595643, repo.id)
        XCTAssertEqual("android-architecture", repo.name)
    }
    
    func testDecodeRepos() {
        let data = try! Data(contentsOf: self.getFilePath(fileName: "get-repos", ofType: "json"), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        
        let repos = try! decoder.decode([Repo].self, from: data)
        
        XCTAssertNotNil(repos)
        XCTAssertEqual(30, repos.count)
    }
    
    func testDecodeHttpbin() {
        let data = try! Data(contentsOf: self.getFilePath(fileName: "post-httpbin", ofType: "json"), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        
        let httpbin = try! decoder.decode(Httpbin.self, from: data)
        
        XCTAssertNotNil(httpbin)
        XCTAssertEqual(123, httpbin.form.id)
        XCTAssertEqual("Alamofire", httpbin.form.name)
    }
}
