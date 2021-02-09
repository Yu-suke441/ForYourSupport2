//
//  Shopping.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/09.
//

import Foundation


struct Shopping: Identifiable {
    let id : Int
    let item_id: Int
    let product_name: String
    let product_price: Int
    let recorded_date: Date

}

extension Shopping {
    init(shoppingDB: ShoppingDB) {
        id = shoppingDB.id
        item_id = shoppingDB.item_id
        product_name = shoppingDB.product_name
        product_price = shoppingDB.product_price
        recorded_date = shoppingDB.recorded_date
    }
}
