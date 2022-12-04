//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

struct ProfileViewModelOutput {
    let moviesLoadedPublisher = PassthroughSubject<[MovieModelView], Never>()
    let nameLoadedPublisher = PassthroughSubject<String, Never>()
    let movieSelectedPublisher = PassthroughSubject<MovieResponse, Never>()
    let closePublisher = PassthroughSubject<Void, Never>()
}
