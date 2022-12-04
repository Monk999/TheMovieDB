//
//  LoginCoordinator.swift
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Foundation
import Combine
import UIKit

class MovieDetailCordinator: Coordinator {
    var children: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private var subscriptions = Set<AnyCancellable>()
    private let movieID: Int
    
    init(navigationController: UINavigationController, movieId: Int) {
        self.movieID = movieId
        self.navigationController = navigationController
    }

    func start() {
        let builder = MovieDetailSceneBuilder()
        let viewController = builder.build(movieID: movieID)
       
        viewController.viewModel.output.videoSelectedPublisher
            .sink {  [weak self]  video in
                self?.cordinateToVideo(video: video)
            }.store(in: &subscriptions)
        
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: - Flow Methods
    
    func cordinateToVideo(video: VideoResponse) {
        guard let key = video.key, let url = URL(string: APIConstants.youtubeLink + key) else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func cordinateToParent() {
        navigationController.popViewController(animated: true)
    }
 
}
