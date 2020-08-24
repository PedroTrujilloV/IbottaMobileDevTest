//
//  OffersStore.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import Combine


enum StoreError: Error {
    case DataFoundNil(String)
}

class OffersStore: ObservableObject {
    
    /** # For functional reactive programming (Published)*/
    
    var didChange = PassthroughSubject<OffersStore,Never>()
    @Published  var objectList:Array<OfferViewModel> = [] {
        didSet{
            didChange.send(self)
        }
    }
    
    
    /** # For imperative programming (Delegate)*/
    
    private weak var delegate:StoreDelegate?
    
    init(delegate:StoreDelegate) {
        self.delegate = delegate
         load()
    }
    
    init() {
        load()
    }
    
   func load(){
        if let url = Bundle.main.url(forResource: "Offers", withExtension: "json") {
            do {
                if let data = try? Data(contentsOf: url){
                    let decoder = JSONDecoder()
                    self.objectList = try decoder.decode([Offer].self, from: data)
                        .map({ (offer) -> OfferViewModel in
                            let anOfferVM = OfferViewModel(model: offer)
                            return anOfferVM
                        })
                    self.delegate?.storeDidLoad(offers: self.objectList)
                } else {
                    throw StoreError.DataFoundNil("Problem getting data from url: \(url)")
                }
            } catch  {
                print("OffersStore.load(): \(error)")
            }
        }
    }
    
}
