//
//  Storage.swift
//  RealmSample
//
//  Created by Nux on 14/7/2561 BE.
//  Copyright © 2561 Natthawut Haematulin. All rights reserved.
//

import Foundation
import RealmSwift

open class Storage {
    
    private var realm: Realm
    
    init(configuration: Realm.Configuration) {
        realm = try! Realm(configuration: configuration)
    }
    
    
    func saveSingle<T:Object>(_ object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func save<T:Object>(_ object: T) {
        
    }
    
    
    func loadSingle<T:Object>(_ type: T.Type) -> T? {
        return realm.objects(T.self).first
    }
    
    func deleteAll() {
        
    }
}
