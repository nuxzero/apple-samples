//
//  Post.swift
//  RealmSample
//
//  Created by Nux on 14/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import Foundation
import RealmSwift

class Post: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var createdAt: Date? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
