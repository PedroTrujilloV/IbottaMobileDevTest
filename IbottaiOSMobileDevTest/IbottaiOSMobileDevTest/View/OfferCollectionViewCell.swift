//
//  OfferCollectionViewCell.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import Combine

class OfferCollectionViewCell: UICollectionViewCell {
    
    static let reuserIdentifier: String = "OfferCollectionViewCellReuserIdentifier"
    private var cancellable: AnyCancellable?
    private(set) var isLoading = false

    
    private var imageView = UIImageView()
    private var textTitle = UILabel()
    private var textDescription = UILabel()
    
    private let stackView   = UIStackView()
    private let stackViewText   = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .orange
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        cancellable?.cancel()
    }
    
    func setup(){
        setupImageView()
        setupText()
        setupStackView()
    }
    
    private func setupImageView(){
        imageView.backgroundColor = UIColor.systemGray2
        imageView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "iblogo")
    }
    
    private func setupText(){
        textTitle.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        textTitle.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textTitle.text  = "-$0.00 cash back :("
        textTitle.textAlignment = .left
        
        textDescription.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        textDescription.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        textDescription.text  = "none product :("
        textDescription.textAlignment = .left
    }
    
    func setupStackView(){
        
        stackViewText.axis  = NSLayoutConstraint.Axis.vertical
        stackViewText.distribution  = UIStackView.Distribution.equalSpacing
        stackViewText.alignment = UIStackView.Alignment.center
        stackViewText.spacing   = 3.0

        stackViewText.addArrangedSubview(textTitle)
        stackViewText.addArrangedSubview(textDescription)
        stackViewText.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(stackViewText)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)

        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    public func set(from viewModel:OfferViewModel) {
        if let imgUrl = URL(string: viewModel.url ){
            cancellable = loadImage(for: imgUrl)
//            .handleEvents(receiveSubscription: { [weak self] (subscription) in
//                <#code#>
//            }, receiveCompletion: { [weak self] (completion) in
//                <#code#>
//            }, receiveCancel: { [weak self]  in
//                <#code#>
//            })
            .assign(to: \.imageView.image, on: self )
        }
        textTitle.text = viewModel.current_value
        textDescription.text = viewModel.description
    }
    
    private func loadImage(for url:URL) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
    
}

