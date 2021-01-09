//
//  Httpbin.swift
//  AlamofireSample
//
//  Created by Nux on 16/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import Foundation

struct Httpbin: Codable {
    let origin: String
    let url: String
    let form: Repo
}
