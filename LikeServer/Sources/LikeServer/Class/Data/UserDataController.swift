//
//  UserManager.swift
//  LikeServer
//
//  Created by Jaemin Hong on 10/26/24.
// 

import Foundation

internal final class UserDataController: DataControllable {
    private lazy var defaultURL: URLComponents = LikeServer.shared.defaultURL
    
    func makeURL(_ parameter: GetParameter) throws -> URLComponents {
        var query: String = ""
        
        switch parameter {
        case .userWithID(let id):
            query = "\(id)"
        case .userWithName(let name):
            query = "\(name)"
        default:
            throw HTTPError.badRequest
        }
        
        defaultURL.path = "/\(RequestType.users.rawValue)/\(query)"
        return defaultURL
    }
    
    func makeResult(_ data: Data) throws -> GetResult {
        let decoder = JSONDecoder()
        
        do {
            let user: User = try decoder.decode(User.self, from: data)
            return GetResult.user(result: user)
        } catch {
            throw error
        }
    }
}
