//
//  GraphView.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2020/12/31.
//

import SwiftUI
import SwiftUICharts

struct GraphView: View {
    
    var item: Item!
    
    var body: some View {
        LineView(data: item.numbers, title: "\(item.name)")
        // legend is optional, use optional .padding()
        
    }
}



//struct GraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        GraphView(item: )
//    }
//}
