//
//  MemoView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI

struct MemoView: View {
    @State var isOnToggle = false
    @State var isOnToggle2 = false
    let item: Item!
    @State var contents = ""
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
                    Text("\(item.name):\(contents)")
                        .font(.title)
                        .lineLimit(1)
                }
                .sheet(isPresented: $isOnToggle) {
                    CharacterInputView(item: Item(id: item.id, name: item.name, icon_file: item.icon_file, record_type: item.record_type, odr: item.odr), content: $contents)
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
                    CharacterTypeListView(viewModel: CharacterTypeViewModel(item: item))
                }
            }
        }
        .background(Color(.white))
        .frame(maxWidth: .infinity)
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(item: Item(id: 1, name: "", icon_file: "", record_type: "", odr: 1))
    }
}
