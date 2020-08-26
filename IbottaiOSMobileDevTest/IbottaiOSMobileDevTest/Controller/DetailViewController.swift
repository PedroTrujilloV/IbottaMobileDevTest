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

    private var offerViewModel:OfferViewModel
    private var cancellable: AnyCancellable?

    private var productImageView = UIImageView()
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var termsTextView: UITextView?
    private var currentValueLabel = UILabel()
    
    private var textStackView = UIStackView()
    private var stackView = UIStackView()
    
    private let defaultImage = UIImage(named: "iblogo")
    private let likeStateImageView = UIImageView(image: UIImage(systemName: "heart.fill") )
    
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
        setupImageView()
        setupText()
        setupStackView()
    }
       
    private func setupImageView(){
        
        productImageView.backgroundColor = UIColor.systemGray2
        productImageView.heightAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.cornerRadius = 5
        productImageView.layer.masksToBounds = true
        productImageView.image = defaultImage
        
        if let imgUrl = URL(string: self.offerViewModel.url ){
             cancellable = loadImage(for: imgUrl)
                       .assign(to: \.productImageView.image, on: self )
        }
           
        likeStateImageView.tintColor = UIColor.ibColor
    }
       
    private func setupText(){
        
        nameLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        nameLabel.text  = "-$0.00 cash back :("
        nameLabel.textAlignment = .left
           
        currentValueLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        currentValueLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        currentValueLabel.text  = "none product :("
        currentValueLabel.textAlignment = .left
        
        descriptionLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        descriptionLabel.text  = "none product :("
        descriptionLabel.textAlignment = .left
    }
       
    func setupStackView(){
           
        textStackView.axis  = NSLayoutConstraint.Axis.vertical
        textStackView.distribution  = UIStackView.Distribution.equalSpacing
        textStackView.alignment = UIStackView.Alignment.center
        textStackView.spacing   = 8.0

        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(currentValueLabel)
        textStackView.addArrangedSubview(descriptionLabel)

        textStackView.translatesAutoresizingMaskIntoConstraints = false
           
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0

        stackView.addArrangedSubview(productImageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)

        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func loadImage(for url:URL) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }

}
