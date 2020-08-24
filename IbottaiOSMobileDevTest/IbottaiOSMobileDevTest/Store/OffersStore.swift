//
//  OffersStore.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import Combine

class OffersStore:ObservableObject {
    
    @Published var objectList:Array<Any> = []
    
    init() {
        
    }
    
    private func load(){
        
        if let url = Bundle.main.url(forResource: "Offers", withExtension: "json") {
            do {
                if let data = try? Data(contentsOf: url) {
                    let decoder = JSONDecoder()
                    
                }
                
            } catch  {
                print("OffersStore.load(): \(error)")
            }
        }
//        if let url = Bundle.main.url(forResource: "form", withExtension: "plist") {
//           do {
//               var cellVMs: [CellViewModel] = []
//               if let data =  try? Data(contentsOf: url) {
//                   let decoder = PropertyListDecoder()
//                   cellVMs = try decoder.decode([CellModel].self, from: data)
//                       .map({ (cellM) -> CellViewModel in
//                           let aCellVM = CellViewModel(cellModel: cellM)
//                           aCellVM.makeBinding(with: formVM)
//                           return aCellVM
//                       })
//               }
//               snapshotForCurrentState(cells: cellVMs)
//           } catch {
//               print("FormViewController.loadPlist(): problem \(error)")
//           }
//       }
    }
    
}
