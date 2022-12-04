//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

struct LoginViewModelInput {
    let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    let userInputPublisher = PassthroughSubject<String?, Never>()
    let passwordInputPublisher = PassthroughSubject<String?, Never>()
    let loginPublisher = PassthroughSubject<Void, Never>()
}
