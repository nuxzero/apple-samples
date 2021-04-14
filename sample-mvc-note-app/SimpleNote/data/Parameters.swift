//
//  Parameters.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 24/1/2564 BE.
//

import Foundation

protocol Parameters: Encodable {
    
}

extension Parameters {
    func encodeData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateUtils.dateFormatter)
        return try encoder.encode(self)
    }
}
