//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

protocol UserLogUseCaseProtocol {
    func login(user: String, password: String) -> AnyPublisher<Void, LoginResponseError>
}
