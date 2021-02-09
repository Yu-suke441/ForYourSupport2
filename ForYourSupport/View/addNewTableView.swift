//
//  addNewTableView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/02/01.
//

import SwiftUI

struct addNewTableView: View {
    var selections = ["Number", "Memo"]
    @State private var selection = 0
    @State private var iconIndex = 0
    var icons = ["chart","graph","detail","check-mark","heart_rate","meal","memo","shopping","task","thermometer","through","time_of_sleep","weight-scale"]
    @Binding var tableName: String
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var itemStore: ItemStore
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("テーブル名").foregroundColor(.black)) {
                    TextField("テーブル名", text:$tableName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.black)
                }
                Section(header: Text("アイコン追加").foregroundColor(.black)) {
                    Picker(selection: $iconIndex, label: Text("アイコンの追加").foregroundColor(.black)) {
                        ForEach(0 ..< icons.count) { (item_icon) in
                            Image(self.icons[item_icon])
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding()
                                .tag(item_icon)
                        }
                    }
                }
                Section(header: Text("入力タイプ").foregroundColor(.black)) {
                    Picker(selection: $selection, label: Text("\(selection)")) {
                        ForEach(0..<selections.count) {
                            Text(self.selections[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("テーブルの追加")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                            presentation.wrappedValue.dismiss()

                    }, label: {
                        Text("キャンセル")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                            presentation.wrappedValue.dismiss()
                        itemStore.create(name: tableName, icon_file: self.icons[iconIndex], record_type: selections[selection], odr: 5)

                    }, label: {
                        Text("テーブル追加")
                    })
                }
            }
            
        }
    }
}

//struct addNewTableView_Previews: PreviewProvider {
//    static var previews: some View {
//        addNewTableView()
//    }
//}
