//
//  Number.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/09.
//

import Foundation


struct Number: Identifiable {
    let id : Int
    let item_id: Int
    let value :Double
    let recorded_at: Date
    
}

extension Number {
    init(numberDB: NumberDB) {
        id = numberDB.id
        item_id = numberDB.item_id
        value = numberDB.value
        recorded_at = numberDB.recorded_at
           
    }
}
