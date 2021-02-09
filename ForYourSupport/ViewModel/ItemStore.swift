//
//  ItemStore.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI
import RealmSwift

final class ItemStore: ObservableObject {
    
    private var itemResults: Results<ItemDB>
    
    // itemResultsにDBのデータをセット
    init(realm: Realm) {
        itemResults = realm.objects(ItemDB.self)

    }
    
    var items: [Item] {
         itemResults.map(Item.init)
    }
    
    
    
}

extension ItemStore {
    // データ追加
    func create(name: String, icon_file: String, record_type: String, odr: Int) {
        objectWillChange.send()
        
        func newID(realm: Realm) -> Int {
            if let item = realm.objects(ItemDB.self).sorted(byKeyPath: "id").last {
                return item.id + 1
            } else {
                    return 1
            }
        }
        
        do {
            let realm = try! Realm()
            let itemDB = ItemDB()
            itemDB.id = newID(realm: realm)
            itemDB.name = name
            itemDB.icon_file = icon_file
            itemDB.record_type = record_type
            itemDB.odr = odr
            try! realm.write {
                realm.add(itemDB)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update(id: Int, odr: Int) {
        objectWillChange.send()
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(ItemDB.self,
                             value: ["id": id,
                                     "order": odr],
                             update: .modified)
            }
        }
        
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(itemID: Int) {
        objectWillChange.send()
        
        guard let itemDB = itemResults.first(where: {$0.id == itemID}) else {
            return
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(itemDB)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func move(sourceIndexSet: IndexSet, destination: Int) {
        guard  let source = sourceIndexSet.first else {
            return
        }
        
        let moveId = items[source].id
        
        if source < destination {
            for i in (source + 1)...(destination - 1) {
                update(id: items[i].id, odr: items[i].odr - 1)
            }
            update(id: moveId, odr: destination - 1)
        } else if destination < source {
            for i in (destination ... (source - 1)).reversed() {
                update(id: items[i].id, odr: items[i].odr + 1)
            }
            update(id: moveId, odr: destination)
        } else {
            return
        }
        
    }
    
}




