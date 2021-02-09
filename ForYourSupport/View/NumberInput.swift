//
//  NumberInput.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI
import KeyboardObserving
import Combine
import RealmSwift




struct ModalView: View {
    @Binding var number: String
    let item: Item!
    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(item.name)) {
                    TextField("数値を入力してください", text: $number)
                        .keyboardType(.decimalPad)
                        
                    }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("\(item.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        update()
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("次へ")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                        number = ""
                    }, label: {
                        Text("キャンセル")
                    })
                }
            }
        }
    }
    func update(){
        func newID(realm: Realm) -> Int {
            if let number = realm.objects(NumberDB.self).sorted(byKeyPath: "id").last {
                return number.id + 1
            } else {
                    return 1
            }
        }
        
        
        let realm = try! Realm()
                            
        let num = NumberDB()
        let itemDB = realm.object(ofType: ItemDB.self, forPrimaryKey: item!.id)

        num.id = newID(realm: realm)
        num.item_id = item!.id
        
        num.value = atof(number)
        num.recorded_at = Date()
        
                        
        try! realm.write{
            itemDB?.numbers.append(num)
            //realm.add(num, update: .modified)
        }
    }
}



//extension Binding where Value == Double {
//    func DoubleToStrDef(_ def: Double) -> Binding<String> {
//        return Binding<String>(get: {
//            return String(self.wrappedValue)
//        }) { value in
//            self.wrappedValue = Double(value) ?? Double(def)
//        }
//    }
//}
