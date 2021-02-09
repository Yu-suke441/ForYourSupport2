//
//  ShoppingStore.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/23.
//

import SwiftUI
import RealmSwift

final class ShoppingStore: ObservableObject {
    
    private var shoppingResults: Results<ShoppingDB>
    
    // numberResultsにDBのデータをセット
    init(realm: Realm) {
        shoppingResults = realm.objects(ShoppingDB.self)
    }
    
    
    var shoppings: [Shopping] {
        shoppingResults.map(Shopping.init)
    }
    
    @EnvironmentObject var store: ItemStore
    var item: Item!
}



extension MemoStore {
   
    
   
    // データ追加
    func create() {
        objectWillChange.send()
        
                
        let realm = try! Realm()
                                
        let memoDB = MemoDB()
        let itemDB = realm.object(ofType: ItemDB.self, forPrimaryKey: item!.id)

        memoDB.id = newID(realm: realm)
        memoDB.item_id = item!.id
            
        memoDB.memo = self.character
        memoDB.recorded_date = Date()
                
                                
        try! realm.write{
            itemDB?.memos.append(memoDB)
            //realm.add(num, update: .modified)
        }
            
        
    }
    
    func newID(realm: Realm) -> Int {
        if let number = realm.objects(ShoppingDB.self).sorted(byKeyPath: "id").last {
            return number.id + 1
        } else {
                return 1
        }
    }

        
    
    
        
}




