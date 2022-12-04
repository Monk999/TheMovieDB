//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

struct MoviesViewModelOutput {
    let requestingDataPublisher = PassthroughSubject<Void, Never>()
    let requestErrorPublisher = PassthroughSubject<Void, Never>()
    let moviesLoadedPublisher = PassthroughSubject<[MovieModelView], Never>()
    let movieSelectedPublisher = PassthroughSubject<MovieResponse, Never>()
}
