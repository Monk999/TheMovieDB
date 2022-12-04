//
//  LoginViewController.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    let viewModel: MoviesViewModelProtocol
    let viewModelInput: MoviesViewModelInput = MoviesViewModelInput()
    
    private var subscriptions = Set<AnyCancellable>()
    
    var movies: [MovieModelView] = []
    
    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming", "Airing Today"]).forAutoLayout()
        view.tintColor = UIColor.white
        view.backgroundColor = UIColor.darkGray
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        view.selectedSegmentTintColor = UIColor.gray
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(sectionChanged), for: .valueChanged)
        return view
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(MovieCell.self)
        view.backgroundColor = .clear
        return view
     }()

    init(viewModel: MoviesViewModelProtocol) {
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
        
        output.requestingDataPublisher.sink { [weak self] message in
            self?.showLoading(show: true)
        }.store(in: &subscriptions)

        output.requestErrorPublisher.sink { [weak self] message in
            self?.showLoading(show: false)
        }.store(in: &subscriptions)
        
        output.moviesLoadedPublisher.sink { [weak self] data in
            self?.showLoading(show: false)
            self?.movies = data
            self?.collectionView.reloadData()
        }.store(in: &subscriptions)
    }
   
    func showLoading(show: Bool) {
        
    }
    
    @objc func menuTapped() {
        viewModelInput.menuTappedPublisher.send()
    }
    
    @objc func sectionChanged() {
        viewModelInput.sectionChangedPublisher.send(segmentedControl.selectedSegmentIndex)
    }
}

extension MoviesViewController: MovieCellDelegate {
    func favoriteTapped(cell: MovieCell) {
        guard let index = collectionView.indexPath(for: cell) else { return }
        let item = movies[index.item]
        viewModelInput.changeIsFavoritePublisher.send(.init(index: index.item, isFavorite: !item.isFavorite))
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        let width = collectionView.frame.width / 2 - 10
        let size = CGSize(width: width, height: 320)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModelInput.movieSelectedPublisher.send(indexPath.item)
    }
    
}

extension MoviesViewController {
    
    private func setupView() {
        view.backgroundColor = UIColor(rgb: 0x0C151A)
        self.title = "TV Shows"
        setupNavBar()
        view.addSubviews(segmentedControl, collectionView)
        setupConstraints()
    }
    
    private func setupNavBar() {
        let newNavBarAppearance = customNavBarAppearance()
        navigationController!.navigationBar.scrollEdgeAppearance = newNavBarAppearance
        navigationController!.navigationBar.compactAppearance = newNavBarAppearance
        navigationController!.navigationBar.standardAppearance = newNavBarAppearance
        if #available(iOS 15.0, *) {
            navigationController!.navigationBar.compactScrollEdgeAppearance = newNavBarAppearance
        }
        if #available(iOS 14.0, *) {
            navigationController!.navigationBar.topItem?.backButtonDisplayMode = .minimal
        } 
        
        var image = UIImage(named: "menu")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(menuTapped))
    }
    
    func customNavBarAppearance() -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()
        
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = .darkGray
        
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        return customNavBarAppearance
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
