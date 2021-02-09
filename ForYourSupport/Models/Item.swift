//
//  Item.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import Foundation


// idという変数を持っていることを示すプロトコルをIdentifiable
struct Item: Identifiable {
    let id : Int
    let name: String
    let icon_file: String
    let record_type: String
    let odr: Int
    var numbers = [Double]()
}

// Item構造体の拡張
extension Item {
    init(itemDB: ItemDB) {
        id = itemDB.id
        name = itemDB.name
        icon_file = itemDB.icon_file
        record_type = itemDB.record_type
        odr = itemDB.odr
        
        for number in itemDB.numbers {
            self.numbers.append(number.value)
        }
            
    }
}
