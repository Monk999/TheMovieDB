//
//  MovieCell.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Kingfisher

protocol MovieCellDelegate: AnyObject {
    func favoriteTapped(cell: MovieCell)
}

class MovieCell: UICollectionViewCell, ReusableView {

    var isFavorite: Bool = false {
        didSet {
            let imageName = isFavorite ? "favorite_selected" : "favorite"
            favoriteButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    weak var delegate: MovieCellDelegate?
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.layer.cornerRadius = 15;
        view.layer.masksToBounds = true;
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 12)
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 12)

        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.textAlignment = .right
        view.text = "⭐️"
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 12)

        return view
    }()

    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 12)
        view.numberOfLines = 4
        return view
    }()
    
    private lazy var favoriteButton: UIButton = {
        let view = UIButton().forAutoLayout()
        view.addTarget(self, action: #selector(tapFavorites), for: .touchUpInside)
        return view
     }()


    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapFavorites() {
        delegate?.favoriteTapped(cell: self)
    }

    // MARK: - View configuration
    private func setupViews() {
        contentView.backgroundColor = UIColor(rgb: 0x18272D)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15;
        contentView.layer.masksToBounds = true;

        contentView.addSubviews(imageView, favoriteButton ,titleLabel, dateLabel, ratingLabel, descriptionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(_ model: MovieModelView) {
        titleLabel.text = model.title
        dateLabel.text = model.date
        ratingLabel.text = model.rating
        descriptionLabel.text = model.description
        isFavorite = model.isFavorite
        
        if let url = URL(string: model.imageUrl) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
    }
}
