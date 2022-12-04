//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

struct LoginViewModelOutput {
    let loginSuccessful =  PassthroughSubject<Void, Never>()
    let requestingDataPublisher = PassthroughSubject<Void, Never>()
    let loginIsEnablePublisher = PassthroughSubject<Bool, Never>()
    let requestErrorPublisher = PassthroughSubject<String, Never>()
}
