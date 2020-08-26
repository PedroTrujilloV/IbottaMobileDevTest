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
    
    private var cancellable:AnyCancellable?
    
    private let heartFillImage = UIImage(systemName: "heart.fill")
    private let heartImage = UIImage(systemName: "heart")
    private let exitImage = UIImage(systemName: "xmark")
    
    private var likeItButton : UIBarButtonItem?
    
    private static let processingQueue = DispatchQueue(label: "processingQueue")

    
    init(_ offerVM: OfferViewModel) {
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
        bind()
        setupView()
        setupButtons()
    }
    
    func bind(){
        cancellable = self.offerViewModel.$likeItState
            .subscribe(on: DetailViewController.processingQueue)
            .receive(on: RunLoop.main)
            .sink(receiveValue: {[weak self] (likedIt) in
                if likedIt == true {
                    self?.likeItButton?.image = self?.heartFillImage
                } else {
                    self?.likeItButton?.image = self?.heartImage
                }
            })
    }
    
    func setupButtons() {
        
        likeItButton = UIBarButtonItem(image: heartImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(likeItAction(sender:)))
        likeItButton?.tintColor = UIColor.ibColor
        self.navigationItem.rightBarButtonItem = likeItButton
        
        let exitButton = UIBarButtonItem(image: exitImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeAction(sender:)))
        exitButton.tintColor = UIColor.systemGray
        self.navigationItem.leftBarButtonItem = exitButton
    }
    
    private func setupView() {
        self.title = "Details"
        let view = UIView()
        detailView = DetailView(frame: self.view.frame, offerViewModel: self.offerViewModel)
        view.addSubview(self.detailView ?? UIView())
        self.view = view
    }
    
    @objc private func likeItAction(sender:UIBarButtonItem) {
        toggleLikeIt()
        print("\n toggleLikeIt")
    }
    
    private func toggleLikeIt() {
        offerViewModel.likeItState = !offerViewModel.likeItState
    }
    
    @objc private func closeAction(sender:UIBarButtonItem) {
        dismiss(animated: true) {
            // do something
        }
    }
       
}
