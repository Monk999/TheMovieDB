//
//  LoginViewController.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {

    let viewModel: ProfileViewModelProtocol
    let viewModelInput: ProfileViewModelInput = ProfileViewModelInput()
    
    private var subscriptions = Set<AnyCancellable>()
    
    var movies: [MovieModelView] = []
    
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
    
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.numberOfLines = 0
        view.text = "Profile"
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton().forAutoLayout()
        view.setTitle("X", for: .normal)
        view.tintColor = .white
        view.addTarget(self, action: #selector(close), for: .touchUpInside)
        return view
     }()
    
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView().forAutoLayout()
        view.image = UIImage(named: "profile")
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return view
    }()
    
    private lazy var favoritesLabel: UILabel = {
        let view = UILabel().forAutoLayout()
        view.textColor = UIColor(rgb: 0x62CD71)
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.text = "Favorites Shows"
        return view
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(MovieCell.self)
        view.backgroundColor = .clear
        return view
     }()
    
    init(viewModel: ProfileViewModelProtocol) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelInput.viewWillAppearPublisher.send()
    }
    
    private func bind() {
        let output = viewModel.bind(input: viewModelInput)
        
        output.moviesLoadedPublisher.sink { [weak self] data in
            self?.movies = data
            self?.collectionView.reloadData()
        }.store(in: &subscriptions)
        
        output.nameLoadedPublisher.sink { [weak self] name in
            self?.nameLabel.text = name
        }.store(in: &subscriptions)
    }
    
    @objc func close() {
        viewModel.output.closePublisher.send()
    }
}

extension ProfileViewController: MovieCellDelegate {
    func favoriteTapped(cell: MovieCell) {
        guard let index = collectionView.indexPath(for: cell) else { return }
        let item = movies[index.item]
        viewModelInput.changeIsFavoritePublisher.send(.init(index: index.item, isFavorite: !item.isFavorite))
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as MovieCell
        cell.configure(movies[indexPath.item])
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 30
        let size = CGSize(width: width, height: 280)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModelInput.movieSelectedPublisher.send(indexPath.item)
    }
    
}

extension ProfileViewController {
    
    private func setupView() {
        view.backgroundColor = UIColor(rgb: 0x0C151A)
        self.title = "Profile"
        contentView.addSubviews(titleLabel, collectionView, profileImage, nameLabel, favoritesLabel)
        scrollView.addSubview(contentView)
        view.addSubviews(scrollView, closeButton)
        setupConstraints()
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            favoritesLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 50),
            favoritesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoritesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
