//
//  Repo.swift
//  AlamofireSample
//
//  Created by Natthawut Haematulin on 15/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import Foundation

struct Repo: Codable {
    
    let id: Int64
    let name: String
//    let fullname: String?
//    let createdAt: Date?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
//        case fullname = "full_name"
//        case createdAt = "created_at"
    }
}
