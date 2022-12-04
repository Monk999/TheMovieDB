//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//


import Combine
import Foundation



class UserLogUseCase: UserLogUseCaseProtocol {
    
    static var shared: UserLogUseCase = UserLogUseCase()

    private let repository: LoginRepositoryProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    private init() {
        repository = LoginRepository()
    }

    func login(user: String, password: String) -> AnyPublisher<Void, LoginResponseError> {
       return repository.login(.init(username: user, password: password))
    }
}
