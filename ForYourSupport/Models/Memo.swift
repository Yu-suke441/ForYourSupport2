//
//  Memo.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/09.
//

import Foundation


struct Memo: Identifiable {
    let id : Int
    let item_id: Int
    let memo : String
    let recorded_date: Date

}

extension Memo {
    init(memoDB: MemoDB) {
        id = memoDB.id
        item_id = memoDB.item_id
        memo = memoDB.memo
        recorded_date = memoDB.recorded_date
        
    }
}
