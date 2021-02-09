//
//  MemoStore.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/18.
//

import SwiftUI
import RealmSwift

final class MemoStore: ObservableObject {
    
    private var memoResults: Results<MemoDB>
    @State var character = ""
    // numberResultsにDBのデータをセット
    init(realm: Realm) {
        memoResults = realm.objects(MemoDB.self)
    }
    
    
    var memos: [Memo] {
        memoResults.map(Memo.init)
    }
    
    @EnvironmentObject var store: ItemStore
    var item: Item!
}



extension MemoStore {
   
    
   
    // データ追加
    func create(item_id: Int, memo: String, recorded_date: Date) {
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
            
        func newID(realm: Realm) -> Int {
            if let number = realm.objects(NumberDB.self).sorted(byKeyPath: "id").last {
                return number.id + 1
            } else {
                    return 1
            }
        }
    }
    
    

        
    
    
    func update(memo: Memo) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(MemoDB.self,
                             value: [
                                MemoDBKeys.id.rawValue: memo.id,
                                MemoDBKeys.item_id.rawValue: memo.item_id,
                                MemoDBKeys.memo.rawValue: memo.memo,
                                MemoDBKeys.recorded_date.rawValue: memo.recorded_date,
                                
                            
                             ],
                             update: .modified)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(memoDB:Int) {
        objectWillChange.send()
        
        guard let memoDB = memoResults.first(where: {$0.id == memoDB}) else {
            return
        }
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(memoDB)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update(id: Int) {
        objectWillChange.send()

        do {
          let realm = try Realm()
          try realm.write {
            realm.create(MemoDB.self,
                         value: ["id": id
                         ],
                         update: .modified)
          }
        } catch let error {
          print(error.localizedDescription)
        }
    }
    
}




