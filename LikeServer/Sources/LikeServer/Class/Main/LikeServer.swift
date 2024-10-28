//
//  LikeServer.swift
//  LikeServer
//
//  Created by Jaemin Hong on 10/4/24.
//

import Foundation

public final class LikeServer {
    @MainActor public static let shared: LikeServer = LikeServer()
    private var _defaultURL: URLComponents = URLComponents()
    private let dataControllers: [RequestType: DataControllable] = [
        .users: UserDataController()
    ]
    
    internal var defaultURL: URLComponents { _defaultURL }
    
    private init() {
        let domain: String = Bundle.main.infoDictionary?["Domain"] as! String
        _defaultURL.scheme = "https"
        _defaultURL.host = domain
    }
    
    @available(iOS 13.0.0, *)
    @MainActor
    public func get(_ type: RequestType, parameter: GetParameter) async throws -> GetResult {
        let dataController = dataControllers[type]!
        _defaultURL = try dataController.makeURL(parameter)
        
        guard let url = defaultURL.url else { throw HTTPError.notFound }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw HTTPError.badRequest }
            
            if (400...599).contains(httpResponse.statusCode) {
                throw getHTTPError(httpResponse.statusCode)
            }
            
            let result = try dataController.makeResult(data)
            return result
        } catch {
            throw error
        }
    }
    
    private func getHTTPError(_ statusCode: Int) -> HTTPError {
        switch statusCode {
        case 400:
            return HTTPError.badRequest
        case 401:
            return HTTPError.unauthorized
        case 403:
            return HTTPError.forbidden
        case 404:
            return HTTPError.notFound
        case 405:
            return HTTPError.methodNotAllowed
        case 408:
            return HTTPError.requestTimeout
        case 409:
            return HTTPError.conflict
        case 410:
            return HTTPError.gone
        case 412:
            return HTTPError.preconditionFailed
        case 413:
            return HTTPError.payloadTooLarge
        case 415:
            return HTTPError.unsupportedMediaType
        case 429:
            return HTTPError.tooManyRequests
        case 500:
            return HTTPError.internalServerError
        case 501:
            return HTTPError.notImplemented
        case 502:
            return HTTPError.badGateway
        case 503:
            return HTTPError.serviceUnavailable
        case 504:
            return HTTPError.gatewayTimeout
        default:
            return HTTPError.notFound
        }
    }
}
