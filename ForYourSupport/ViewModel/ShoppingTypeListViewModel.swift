//
//  ShoppingTypeListViewModel.swift
//  ForYourSupport
//
//  Created by Yusuke Murayama on 2021/01/22.
//

import Combine
import Foundation
import RealmSwift

final class ShoppingTypeListViewModel: ObservableObject {
    @Published var shoppings: [ShoppingDB] = []
    @Published var isLoading = false
    var item: Item!
    var memoTables: Results<ShoppingDB>!
    
    private var cancellables: Set<AnyCancellable> = []

    private let perPage = 20
    private var currentPage = 1
    init(item: Item) {
        self.item = item
    }
    func loadNext(item: ShoppingDB) {
        if shoppings.isLastItem(item) {
            self.currentPage += 1
            getNumberList(page: currentPage, perPage: perPage) { [weak self] result in
                    self?.handleResult(result)
            }
        }
    }
    
    func onAppear() {
        getNumberList(page: currentPage, perPage: perPage) { [weak self] result in
                 self?.handleResult(result)
            }
    }
    
    private func getNumberList(page: Int, perPage: Int,
                                  completion: @escaping (Result<[ShoppingDB], Error>) -> Void) {

        let parameters: [String: Any] = [
                "page": currentPage,
                "per_page": perPage,
            ]
        
        print(item)
        let realm = try! Realm()
        let itemDB = realm.object(ofType: ItemDB.self, forPrimaryKey: item!.id)
        let results = itemDB?.shoppings
        self.shoppings = results!.compactMap({ (memoTable) -> ShoppingDB? in
            return memoTable
            
        })

    }
    
    private func handleResult(_ result: Result<[ShoppingDB], Error>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.isLoading = false
            switch result {
            case .success(let items):
                self.currentPage += 1
                self.shoppings.append(contentsOf: items)
            case .failure(let error):
                self.currentPage = 1
                print(error)
            }
        }
    }
}
