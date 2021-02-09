//
//  ShoppingView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI

struct ShoppingView: View {
    
    @State var isOnToggle = false
    @State var isOnToggle2 = false
    @State var shoppingMenus = ""
    @State var shoppingMoneys: Int
    let item: Item!
   
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(item.icon_file)
                    .resizable()
                    .frame(width:44, height: 44)
                Text(item.name)
                    .font(.title)
                    .lineLimit(1)
                    .foregroundColor(.black)
                Spacer()
                
            }.padding()
            
            HStack {
                Spacer()
                Button(action: {
                    self.isOnToggle.toggle()
                }) {
                    VStack {
                        Text("買ったもの:\(shoppingMenus)").font(.title)
                        Text("買った金額:\(shoppingMoneys)").font(.title)
                    }
                }
                .sheet(isPresented: $isOnToggle) {
                    ShoppingInputView(item: Item(id: item.id, name: item.name, icon_file: item.icon_file, record_type: item.record_type, odr: item.odr), shoppingMenu: $shoppingMenus,shoppingMoney: $shoppingMoneys)
                }
                Spacer()
                Button(action: {
                    self.isOnToggle2.toggle()
                }, label: {
                    Image("chart")
                        .resizable()
                        .frame(width:50, height: 50)
                })
                .padding()
                .sheet(isPresented: $isOnToggle2) {
                    ShoppingTypeListView(viewModel: ShoppingTypeListViewModel(item: item))
                }
            }
            
        }
        .background(Color(.white))
        .frame(maxWidth: .infinity)
    }
}



struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(shoppingMoneys: 0, item: Item(id: 1, name: "", icon_file: "", record_type: "", odr: 1))
    }
}

