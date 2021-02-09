//
//  ItemListView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var store: ItemStore
    @State var items: [Item]
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 1)
    var body: some View {
        
         ScrollView {
             LazyVGrid(columns: columns) {
                ForEach(items) { item in
                    HStack {
                        ItemRowView(item: item)
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {
                                    store.delete(itemID: item.id)
                                }, label: {
                                    Text("テーブルの削除")
                                })
                            }))
                    }
                }
             }
             .padding()
             .font(.largeTitle)
         }
    }
}
