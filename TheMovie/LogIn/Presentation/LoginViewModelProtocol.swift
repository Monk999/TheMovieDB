//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

protocol LoginViewModelProtocol {
    var output: LoginViewModelOutput { get }
    func bind(input: LoginViewModelInput) -> LoginViewModelOutput
}
