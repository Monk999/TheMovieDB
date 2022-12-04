//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

struct MovieDetailViewModelOutput {
    let requestingDataPublisher = PassthroughSubject<Void, Never>()
    let requestErrorPublisher = PassthroughSubject<Void, Never>()
    let detailLoadedPublisher = PassthroughSubject<MovieDetailModelView, Never>()
    let isFavoritePublisher = PassthroughSubject<Bool, Never>()
    let videosLoadedPublisher = PassthroughSubject<[VideoModelView], Never>()
    let videoSelectedPublisher = PassthroughSubject<VideoResponse, Never>()

}
