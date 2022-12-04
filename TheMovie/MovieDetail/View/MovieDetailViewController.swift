//
//  LoginViewController.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

class MovieDetailViewController: UIViewController {

    let viewModel: MovieDetailViewModelProtocol
    let viewModelInput: MovieDetailViewModelInput = MovieDetailViewModelInput()
    
    private var subscriptions = Set<AnyCancellable>()
        
    var model: MovieDetailModelView?
    
    var videos: [VideoModelView] = []
    
    var isFavorite: Bool = false {
        didSet {
            let imageName = isFavorite ? "favorite_selected" : "favorite"
            favoriteButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20)
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton().forAutoLayout()
        view.setTitle("X", for: .normal)
        view.tintColor = .white
        view.addTarget(self, action: #selector(close), for: .touchUpInside)
        return view
     }()
    
    private lazy var favoriteButton: UIButton = {
        let view = UIButton().forAutoLayout()
        view.addTarget(self, action: #selector(tapFavorites), for: .touchUpInside)
        return view
     }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView().forAutoLayout()
        view.backgroundColor = .clear
        return view
     }()
    
    private lazy var contentView: UIView = {
        let view = UIView().forAutoLayout()
        view.backgroundColor = .clear
        return view
     }()
    
    
    private lazy var videosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout).forAutoLayout()
        view.dataSource = self
        view.delegate = self
        view.dataSource = self
        view.register(VideoCollectionViewCell.self)
        view.backgroundColor = .clear
        return view
     }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout).forAutoLayout()
        view.dataSource = self
        view.delegate = self
        view.register(CompanyCollectionViewCell.self)
        view.backgroundColor = .clear
        return view
     }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView().forAutoLayout()
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var stackView: UIStackView = {
        var view = UIStackView().forAutoLayout()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillProportionally
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return view
    }()
    
    private lazy var homePageLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return view
    }()
    
    private lazy var lenguageLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return view
    }()

    private lazy var videosLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.text = "Videos"
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
        viewModelInput.viewDidLoadPublisher.send()
    }
    
    private func bind() {
        let output = viewModel.bind(input: viewModelInput)
        
        output.requestingDataPublisher.sink { [weak self] message in
            self?.showLoading(show: true)
        }.store(in: &subscriptions)

        output.requestErrorPublisher.sink { [weak self] message in
            self?.showLoading(show: false)
        }.store(in: &subscriptions)
        
        output.detailLoadedPublisher.sink { [weak self] data in
            self?.showLoading(show: false)
            self?.model = data
            self?.updateData()
        }.store(in: &subscriptions)
        
        output.videosLoadedPublisher.sink { [weak self] data in
            self?.videos = data
            self?.videosCollectionView.reloadData()
        }.store(in: &subscriptions)
        
        output.isFavoritePublisher.sink { [weak self] isFavorite in
            self?.isFavorite = isFavorite
        }.store(in: &subscriptions)
    }
    
    func showLoading(show: Bool) {
        show ? loadingView.startAnimating() : loadingView.stopAnimating()
    }
    
    func updateData() {
        guard let model = model else {
            return
        }

        titleLabel.text = model.title
        ratingLabel.text = model.rating
        descriptionLabel.text = model.description
        dateLabel.text = model.date
        statusLabel.text = model.status
        homePageLabel.text = model.homepage
        lenguageLabel.text = model.originaLanguage
        
        if let url = URL(string: model.imageUrl) {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url)
        }
        
        collectionView.reloadData()
    }
    
    @objc func tapFavorites() {
        viewModelInput.changeIsFavoritePublisher.send(!isFavorite)
    }
    
    @objc func close() {
        viewModel.output.closePublisher.send()
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return model?.companies.count ?? 0
        }else {
            return videos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as CompanyCollectionViewCell
            cell.configure(model!.companies[indexPath.item] )
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(for: indexPath) as VideoCollectionViewCell
            cell.configure(videos[indexPath.item] )
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let size = CGSize(width: 60, height: 50)
            return size
        } else {
            let size = CGSize(width: 100, height: 70)
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.videosCollectionView {
            viewModelInput.videoSelectedPublisher.send(indexPath.item)
        }
    }
    
}

extension MovieDetailViewController {
    
    private func setupView() {
        view.backgroundColor = UIColor(rgb: 0x0C151A)
        stackView.addArrangedSubviews(homePageLabel, lenguageLabel, dateLabel, statusLabel, ratingLabel)
        contentView.addSubviews(titleLabel, loadingView, imageView, favoriteButton, stackView, collectionView, descriptionLabel, videosLabel, videosCollectionView)
        scrollView.addSubview(contentView)
        view.addSubviews(scrollView, closeButton)
        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
        
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
       
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            stackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            videosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            videosLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            videosLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            videosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            videosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            videosCollectionView.topAnchor.constraint(equalTo: videosLabel.bottomAnchor, constant: 5),
            videosCollectionView.heightAnchor.constraint(equalToConstant: 80),
            videosCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
            
        ])
    }
}
