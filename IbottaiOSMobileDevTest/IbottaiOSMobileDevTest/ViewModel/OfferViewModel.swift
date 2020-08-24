//
//  OfferViewModel.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation


struct OfferViewModel:Hashable {
    
    private let model:Offer
    
    var identifier = UUID()
    
    init(model:Offer) {
        self.model = model
    }
    
    var id :String {
        return model.id ?? ""
    }
    var url :String {
        return model.url ?? ""
    }
    var name :String {
        return model.name ?? ""
    }
    var description :String {
        return model.description ?? ""
    }
    var terms :String {
        return model.terms ?? ""
    }
    var current_value :String {
        return model.current_value ?? ""
    }
    
    static func == (lhs: OfferViewModel, rhs: OfferViewModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
