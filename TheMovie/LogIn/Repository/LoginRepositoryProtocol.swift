//
//  TheMovie
//
//  Created by Gerardo on 02/12/22.
//

import Combine
import Foundation

enum LoginResponseError: Error {
    case genericError(message: String)
}

struct LoginResponse: Decodable{
    var username: String
    var password: String
}

struct TokenResponse: Decodable{
    var success: Bool
    var expires_at: String
    var request_token: String
}

struct validateWithLoginResponse: Decodable{
    var success: Bool
    var status_code: Int?
    var status_message: String?
    var session_id: String?
}

struct LoginRequest: Decodable{
    var username: String
    var password: String
}


protocol LoginRepositoryProtocol {
    func login(_ params: LoginRequest) ->  AnyPublisher<Void, LoginResponseError>
}
