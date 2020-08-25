//
//  OfferCollectionViewFlowLayout.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import Foundation
import UIKit

class OfferCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    init(frame:CGRect) {
        super.init()
        self.sectionInset = UIEdgeInsets(top: 22, left: 12, bottom: 12, right:12)
        self.minimumInteritemSpacing = 8
        let width = (frame.width / 2 ) - 16
        self.itemSize = CGSize(width: width , height: width )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
