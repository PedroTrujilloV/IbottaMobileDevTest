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
    private static let processingQueue = DispatchQueue(label: "processingQueue")
    private let heightProportion:CGFloat = 0.65
    
    private let defaultImage = UIImage(named: "iblogo")?.withInset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    private let likeStateImageView = UIImageView(image: UIImage(systemName: "heart.fill") )
    private var imageView = UIImageView()
    private var amountLabel = UILabel()
    private var nameLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let stackView   = UIStackView()
    private let textStackView   = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        setupIcons()
    }
    
    private func setupImageView(){
        imageView.backgroundColor = UIColor.cellImageBackgroundColor
        imageView.heightAnchor.constraint(equalToConstant: self.frame.width * heightProportion).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.image = defaultImage
    }
    
    private func setupText(){
        amountLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        amountLabel.text  = "-$0.00 cash back :("
        amountLabel.textAlignment = .left
        amountLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        amountLabel.textColor = UIColor.amountTextColor
        
        nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        nameLabel.text  = "none product :("
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        nameLabel.textColor = UIColor.nameTextColor
    }
    
    private func setupStackView(){
        textStackView.axis  = NSLayoutConstraint.Axis.vertical
        textStackView.distribution  = UIStackView.Distribution.fillEqually
        textStackView.alignment = UIStackView.Alignment.center
        textStackView.spacing   = 3.0

        textStackView.addArrangedSubview(amountLabel)
        textStackView.addArrangedSubview(nameLabel)
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 8.0

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(stackView)
        activityIndicator.startAnimating()
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupIcons(){
        likeStateImageView.tintColor = UIColor.ibColor
        likeStateImageView.isHidden = true
        let yPos:CGFloat = self.frame.size.height - (self.frame.size.height * heightProportion)
        activityIndicator.center = CGPoint(x: self.frame.size.width/2, y: yPos)
        self.addSubview(activityIndicator)
        self.addSubview(likeStateImageView)
    }
        
    public func set(from viewModel:  OfferViewModel) {
        bind(viewModel)
        amountLabel.text = viewModel.current_value
        nameLabel.text = viewModel.name
    }
    
    private func bind(_ viewModel: OfferViewModel) {
        if let imgUrl = URL(string: viewModel.url ){
            cancellables.append(
                loadImage(for: imgUrl)
                    .handleEvents(receiveSubscription: { [weak self] (subscription) in
                        self?.activityIndicator.startAnimating()
                        }, receiveCompletion: { [weak self] (completion) in
                            self?.activityIndicator.stopAnimating()
                            let margin:CGFloat = 16
                            self?.imageView.image = self?.imageView.image?.withInset(UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
                        }, receiveCancel: { [weak self]  in
                            self?.activityIndicator.stopAnimating()
                    })
                    .assign(to: \.image, on: imageView )
            )
        }
        
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

