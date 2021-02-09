//
//  CharacterInputVIew.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI
import RealmSwift

struct CharacterInputView: View {
    
    let item: Item!
    @State var isOnToggle = false
    @Environment(\.presentationMode) var presentation
    @Binding var content: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(item.name)) {
                    TextEditor(text: $content)
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white,lineWidth: 5)
                        )
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("\(item.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        update(changed: false)
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("次へ")
                    })
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                            presentation.wrappedValue.dismiss()
                            content = ""
                    }, label: {
                        Text("キャンセル")
                    })
                }
            }
        }
    }

    func update(changed: Bool) {
        guard !changed else { return }
        func newID(realm: Realm) -> Int {
            if let number = realm.objects(MemoDB.self).sorted(byKeyPath: "id").last {
                return number.id + 1
            } else {
                    return 1
            }
        }
                    
                
        let realm = try! Realm()
                                
        let memoDB = MemoDB()
        let itemDB = realm.object(ofType: ItemDB.self, forPrimaryKey: item!.id)
        
        memoDB.id = newID(realm: realm)
        memoDB.item_id = item!.id
                
        memoDB.memo = self.content
        memoDB.recorded_date = Date()
                    
                                    
        try! realm.write{
            itemDB?.memos.append(memoDB)
            //realm.add(num, update: .modified)
        }
    }
}
