//
//  SettingView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/27.
//

import SwiftUI
import RealmSwift

struct SettingView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("アプリ初期化").foregroundColor(.black)) {
                    Button(action: {
                        
                        if let fileURL = Realm.Configuration.defaultConfiguration.fileURL {
                            do {
                                
                                try! FileManager.default.removeItem(at: fileURL)
                            } catch let error as NSError {
                                print(error)
                            }
                        }
                        
                        
                        
                    }, label: {
                        Text("アプリを初期化する")
                            .foregroundColor(.black)
                    })
                }
            }
        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
