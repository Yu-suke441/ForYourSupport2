//
//  ShoppingInputView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI
import RealmSwift

struct ShoppingInputView: View {
    @EnvironmentObject var store: ItemStore
    let item: Item!
    @Binding var shoppingMenu: String
    @Binding var shoppingMoney: Int
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("買ったもの")) {
                    TextField("買ったものを入力してください", text: $shoppingMenu)
                }
                Section(header: Text("買った金額")) {
                    TextField("金額を入力しください", text: $shoppingMoney.IntToStrDef(shoppingMoney))
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("\(item.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        create()
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("次へ")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                        shoppingMenu = ""
                        shoppingMoney = 0
                    }, label: {
                        Text("キャンセル")
                    })
                }
            }
        }
    }
    
    func create() {
        func newID(realm: Realm) -> Int {
            if let number = realm.objects(ShoppingDB.self).sorted(byKeyPath: "id").last {
                return number.id + 1
            } else {
                    return 1
            }
        }
        
        
        let realm = try! Realm()
                            
        let shoppingDB = ShoppingDB()
        let itemDB = realm.object(ofType: ItemDB.self, forPrimaryKey: item!.id)

        shoppingDB.id = newID(realm: realm)
        shoppingDB.item_id = item!.id
        shoppingDB.product_name = self.shoppingMenu
        shoppingDB.product_price = self.shoppingMoney
        shoppingDB.recorded_date = Date()
        
                        
        try! realm.write{
            itemDB?.shoppings.append(shoppingDB)
//                            realm.add(num, update: .modified)
        }
    }
}

extension Binding where Value == Int {
    func IntToStrDef(_ def: Int) -> Binding<String> {
        return Binding<String>(get: {
            return String(self.wrappedValue)
        }) { value in
            self.wrappedValue = Int(value) ?? Int(def)
        }
    }
}
