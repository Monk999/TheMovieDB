//
//  CompanyCollectionViewCell.swift
//  TheMovie
//
//  Created by Gerardo on 03/12/22.
//

import UIKit



class VideoCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.image = UIImage(named: "play")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.systemFont(ofSize: 10, weight: .light)
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

    // MARK: - View configuration
    private func setupViews() {
        contentView.backgroundColor = UIColor(rgb: 0x18272D)
        contentView.addSubviews(imageView, titleLabel)
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    func configure(_ model: VideoModelView) {
        titleLabel.text = model.title
    }
}

