//
//  DetailViewController.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    private var detailView: DetailView?
    private var offerViewModel:OfferViewModel
    
    init(_ offerVM:inout OfferViewModel) {
        self.offerViewModel = offerVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        setupView()
    }
    
    private func setupView() {
        let view = UIView()
        detailView = DetailView(frame: self.view.frame, offerViewModel: &self.offerViewModel)
        view.addSubview(self.detailView ?? UIView())
        self.view = view
    }
       
}
