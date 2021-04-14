//
//  Request.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 23/1/2564 BE.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
}

struct Request<T> {
    var path: String
    var method: RequestMethod
    var body: Parameters?
}
