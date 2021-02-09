//
//  NumberDB.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/09.
//

import Foundation
import RealmSwift

class NumberDB: Object , Identifiable{
    
    @objc dynamic var id:Int = 0
    
    @objc dynamic var item_id:Int = 1
    
    @objc dynamic var value:Double = 0
    
    @objc dynamic var recorded_at =  Date()
    
    let itemDBs = LinkingObjects(fromType: ItemDB.self, property: "numbers")
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
}
