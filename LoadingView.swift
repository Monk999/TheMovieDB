//
//  LoadingViewController.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import UIKit

class LoadingView: UIView {

    lazy var activityView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView().forAutoLayout()
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
        addSubview(activityView)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func showInView(view: UIView) {
        view.addSubview(self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        alpha = 0.0
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = 1.0
        }
    }
    
    func remove() {
        UIView.animate(withDuration: 0.2, delay: 0, options: []) { [weak self] in
            self?.alpha = 0.0
        } completion: { [weak self] comp in
            self?.removeFromSuperview()
        }
    }
}
