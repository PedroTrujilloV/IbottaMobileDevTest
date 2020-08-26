//
//  OfferCollectionViewCell.swift
//  IbottaiOSMobileDevTest
//
//  Created by Pedro Trujillo on 8/24/20.
//  Copyright © 2020 Pedro Trujillo V. All rights reserved.
//

import UIKit
import Combine

enum LoadingState {
    case notLoading
    case loading
    case loaded(UIImage)
}

class OfferCollectionViewCell: UICollectionViewCell {
    
    static let reuserIdentifier: String = "OfferCollectionViewCellReuserIdentifier"
    private var cancellables: Array<AnyCancellable> = []
    private let defaultImage = UIImage(named: "iblogo")
    private let likeStateImageView = UIImageView(image: UIImage(systemName: "heart.fill") )
    
    private var imageView = UIImageView()
    private var textTitle = UILabel()
    private var textDescription = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    private let stackView   = UIStackView()
    private let textStackView   = UIStackView()
    
    private static let processingQueue = DispatchQueue(label: "processingQueue")


    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .orange
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit  {
        self.cancel()
    }
    private func cancel(){
        _ = cancellables.map{ $0.cancel()}
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
        imageView.image = defaultImage
        
        likeStateImageView.tintColor = UIColor.ibColor
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
        
        textStackView.axis  = NSLayoutConstraint.Axis.vertical
        textStackView.distribution  = UIStackView.Distribution.equalSpacing
        textStackView.alignment = UIStackView.Alignment.center
        textStackView.spacing   = 3.0

        textStackView.addArrangedSubview(textTitle)
        textStackView.addArrangedSubview(textDescription)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        self.addSubview(likeStateImageView)

        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    public func set(from viewModel:  OfferViewModel) {
        if let imgUrl = URL(string: viewModel.url ){
            cancellables.append(
                loadImage(for: imgUrl)
                .handleEvents(receiveSubscription: { [weak self] (subscription) in
                    self?.activityIndicator.startAnimating()
                }, receiveCompletion: { [weak self] (completion) in
                    self?.activityIndicator.stopAnimating()
                }, receiveCancel: { [weak self]  in
                    self?.activityIndicator.stopAnimating()
                })
                .assign(to: \.imageView.image, on: self )
            )
        }
        textTitle.text = viewModel.current_value
        textDescription.text = viewModel.description
        cancellables.append(
            viewModel.$likeItState
                .subscribe(on: OfferCollectionViewCell.processingQueue)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {[weak self] (likedIt) in
                    self?.likeStateImageView.isHidden = !likedIt
                })
        )
    }
    
    private func loadImage(for url:URL) -> AnyPublisher<UIImage?, Never> {
        return Just(url)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
    
    override func prepareForReuse() {
        imageView.image = defaultImage
        self.likeStateImageView.isHidden = true
        self.cancel()
    }
    
}

