//
//  ViewController.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    var offersCollectionView:OfferCollectionView?
    private var store:OffersStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup(){
        self.setupCollectionView()
        self.setupView()
        self.store = OffersStore(delegate: self)
    }
        
    private func setupView() {
        let view = UIView()
        view.addSubview(self.offersCollectionView ?? UICollectionView())
        self.view = view
    }
}

extension ViewController: UICollectionViewDelegate {
    
    private func setupCollectionView() {
        self.offersCollectionView = OfferCollectionView(frame: self.view.frame)
        self.offersCollectionView?.dataSource = self
        self.offersCollectionView?.delegate = self
    }
    
    private func setupCollectionViewConstrains() { // to - do: fix contraints for landscape
        self.offersCollectionView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.offersCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.offersCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.offersCollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

    }
    
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store?.objectList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let offerCell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferCollectionViewCell.reuserIdentifier, for: indexPath) as! OfferCollectionViewCell
        
        if let offerVM = store?.objectList[indexPath.row] {
            offerCell.set(from: offerVM)
        }
        return offerCell
    }
    
    
}

extension ViewController: StoreDelegate {
    func storeDidLoad(offers: Array<OfferViewModel>) {
        
        self.offersCollectionView?.reloadData()
    }
}

