//
//  ShoppingDB.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/09.
//

import Foundation
import RealmSwift

class ShoppingDB: Object, Identifiable {
    @objc dynamic var id = 0
    
    @objc dynamic var item_id = 3
    
    @objc dynamic var product_name = ""
    
    @objc dynamic var product_price = 0
    
    @objc dynamic var recorded_date = Date()
    
    let itemDBs = LinkingObjects(fromType: ItemDB.self, property: "shoppings")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
