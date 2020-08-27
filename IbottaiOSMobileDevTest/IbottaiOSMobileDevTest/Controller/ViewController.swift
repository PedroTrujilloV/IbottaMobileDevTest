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
        viewRespectsSystemMinimumLayoutMargins = false
        let view = UIView()
        view.addSubview(self.offersCollectionView ?? UICollectionView())
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.offersCollectionView?.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate {
    
    private func setupCollectionView() {
        self.offersCollectionView = OfferCollectionView(frame: self.view.frame)
        self.offersCollectionView?.dataSource = self
        self.offersCollectionView?.delegate = self
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
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let offerVM = store?.objectList[indexPath.row] {
            let detailVC = DetailViewController(offerVM)
            presentDetailViewController(detailVC)
        }
    }
    
    private func presentDetailViewController(_ detailVC: DetailViewController) {
       let nc = UINavigationController(rootViewController: detailVC)
       nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       nc.navigationBar.shadowImage = UIImage()
       nc.navigationBar.isTranslucent = true
       nc.view.backgroundColor = UIColor.clear
       
       self.present(nc, animated: true) {
           //do something
       }
    }
    
}

extension ViewController: StoreDelegate {
    func storeDidLoad(offers: Array<OfferViewModel>) {
        
        self.offersCollectionView?.reloadData()
    }
}

