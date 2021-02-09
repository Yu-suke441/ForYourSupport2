//
//  RealmPersistentInitializer.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import Foundation
import RealmSwift

class RealmPersistent {
    static func initializer() -> Realm {
        do {
            let realm = try Realm()
            return realm
        } catch let error {
            fatalError("Failed to open Realm error: \(error.localizedDescription)")
        }
    }
}
