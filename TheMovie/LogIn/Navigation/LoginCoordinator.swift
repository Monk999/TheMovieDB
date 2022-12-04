//
//  LoginCoordinator.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine
import UIKit

class LoginCordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private var subscriptions = Set<AnyCancellable>()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let builder = LoginSceneBuilder()
        let viewController = builder.build()
        viewController.viewModel.output.loginSuccessful
            .sink { [weak self] in
                self?.coordinateToHome()
            }.store(in: &subscriptions)

        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToHome() {
    
        let cor = MoviesCordinator(navigationController: navigationController)
        coordinate(to: cor)
    }
}
