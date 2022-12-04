

import Foundation
import Combine


class LoginRepository: LoginRepositoryProtocol {
    
    private let session = URLSession.shared
    
    public init() { }
    
    func login(_ params: LoginRequest) ->  AnyPublisher<Void, LoginResponseError> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            self.getToken { result in
                switch result {
                case .failure(let error):
                    promise(.failure(.genericError(message: error.localizedDescription)))
                case .success(let tokenResponse):
                    
                    let urlS = APIConstants.validateWithLoginEndPoint + APIConstants.api_key
                    
                    let url = URL(string: urlS)!
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    
                    let params = [
                        "username": params.username,
                        "password": params.password,
                        "request_token": tokenResponse.request_token
                        
                    ] as [String:Any]
                    
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    let task = self.session.dataTask(with: request) { data, response, error in
                        if let error = error {
                            promise(.failure(.genericError(message: error.localizedDescription)))
                            return
                        }
                        
                        if let data = data {
                            do {
                                let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                                print(json!)
                                let decoder = JSONDecoder()
                                let res = try decoder.decode(validateWithLoginResponse.self, from: data)
                                guard res.success else {
                                    return                                promise(.failure(.genericError(message: res.status_message ?? "Server Error")))
                                }
                                promise(.success(()))
                            } catch {
                                promise(.failure(.genericError(message: "Server Error")))
                            }
                        }
                    }
                    
                    task.resume()
                    
                }
            }
            
            
        }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
        
    func getToken(closure: @escaping (Result<TokenResponse, Error>) -> Void) {

        let urlS = APIConstants.tokenEndpoint + APIConstants.api_key
        
        let url = URL(string: urlS)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                closure(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    
                    let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print(json!)
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(TokenResponse.self, from: data)
                    closure(.success(res))
                    print(res)
                } catch {
                    closure(.failure(error))
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    
}
