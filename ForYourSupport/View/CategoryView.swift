//
//  CategoryView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI

struct CategoryView: View {
    let item: Item!
    @State var number: String
    
    var body: some View {
        if item.record_type == "Number" {
            NumberView(number: number, item: item)
                .cornerRadius(7)
                .shadow(radius:3)
        } else if item.record_type == "Memo" {
            MemoView(item: item)
                .cornerRadius(7)
                .shadow(radius:3)
        } else if item.record_type == "Shopping" {
            ShoppingView(shoppingMoneys: 0, item: item)
                .cornerRadius(7)
                .shadow(radius:3)
        }
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            CategoryView(item: Item(id: 0, name: "体重(kg)", icon_file: "weight-scale", record_type: "Number", odr: 0), value: 0)
//        CategoryView(item: Item(id: 1, name: "体温(℃)", icon_file: "thermometer", record_type: "Number" , odr: 1), value: 0)
//        CategoryView(item: Item(id: 2, name: "メモ", icon_file: "memo", record_type: "Memo" , odr: 2), value: 0)
//        CategoryView(item: Item(id: 3, name: "買い物(円)", icon_file: "shopping", record_type: "Shopping" , odr: 3), value: 0)
//        CategoryView(item: Item(id: 4, name: "一日一善", icon_file: "check-mark", record_type: "Memo" , odr: 4), value: 0)
//        }
//    }
//}
