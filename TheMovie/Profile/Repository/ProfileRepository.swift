

import Foundation
import Combine


class ProfileRepository: ProfileRepositoryProtocol {
    
    static var shared = ProfileRepository()
    
    private init() {}
    
    var name: String = ""
}
