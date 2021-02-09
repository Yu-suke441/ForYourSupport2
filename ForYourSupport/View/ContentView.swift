//
//  ContentView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject var store: ItemStore
    var item : Item
    @State var tableName: String
    var body: some View {
        VStack(spacing: 0) {
            Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)).edgesIgnoringSafeArea(.top).frame(height:0)
            
            NavigationBarView(item: item, tableName: tableName)
            ItemListView(items: store.items)
                
        }
        .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear() {
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            var itemConfig = Realm.Configuration()
            itemConfig.fileURL = itemConfig.fileURL!.deletingLastPathComponent()
                .appendingPathComponent("item.realm")
            
            
            
        }
        
        
        
    }
    
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//        
//    }
//}
//
