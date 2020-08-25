//
//  OfferCollectionView.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit

class OfferCollectionView: UICollectionView {
    init(frame: CGRect) {
        let layout = OfferCollectionViewFlowLayout(frame: frame)
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    private func setup() {
        self.register(OfferCollectionViewCell.self, forCellWithReuseIdentifier: OfferCollectionViewCell.reuserIdentifier)
        self.backgroundColor = UIColor.systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
