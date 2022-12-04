//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation


struct MoviesViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    let viewWillAppearPublisher = PassthroughSubject<Void, Never>()
    let menuTappedPublisher = PassthroughSubject<Void, Never>()
    let sectionChangedPublisher = PassthroughSubject<Int, Never>()
    let movieSelectedPublisher = PassthroughSubject<Int, Never>()
    let changeIsFavoritePublisher = PassthroughSubject<ChangeIsFavoritePublisherParameters, Never>()
}


struct ChangeIsFavoritePublisherParameters {
    let index: Int
    let isFavorite: Bool
}
