//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation


struct ProfileViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    let viewWillAppearPublisher = PassthroughSubject<Void, Never>()
    let movieSelectedPublisher = PassthroughSubject<Int, Never>()
    let changeIsFavoritePublisher = PassthroughSubject<ChangeIsFavoritePublisherParameters, Never>()
}
