//
//  DetailViewController.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/25/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private var detailView: DetailView?
    private var offerViewModel:OfferViewModel
    
    private let heartFillImage = UIImage(systemName: "heart.fill")
    private let heartImage = UIImage(systemName: "heart")
    private let exitImage = UIImage(systemName: "xmark")
    
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
        setupButtons()
    }
    
    func setupButtons() {
        let likeItButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: Selector(("likeItAction")))
        likeItButton.tintColor = UIColor.ibColor
        self.navigationItem.rightBarButtonItem = likeItButton
        
        let exitButton = UIBarButtonItem(image: exitImage, style: UIBarButtonItem.Style.plain, target: self, action: Selector(("closeAction")))
        exitButton.tintColor = UIColor.systemGray
        self.navigationItem.leftBarButtonItem = exitButton
    }
    
    private func setupView() {
        self.title = "Details"
        let view = UIView()
        detailView = DetailView(frame: self.view.frame, offerViewModel: &self.offerViewModel)
        view.addSubview(self.detailView ?? UIView())
        self.view = view
    }
       
}
