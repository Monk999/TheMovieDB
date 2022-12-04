//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

struct MovieDetailViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    let closePublisher = PassthroughSubject<Void, Never>()
    let changeIsFavoritePublisher = PassthroughSubject<Bool, Never>()
    let videoSelectedPublisher = PassthroughSubject<Int, Never>()

}
