//
//  HTTPError.swift
//  LikeServer
//
//  Created by Jaemin Hong on 10/26/24.
// 

import Foundation

internal enum HTTPError: String, Error {
    case badRequest            // 400
    case unauthorized          // 401
    case forbidden             // 403
    case notFound              // 404
    case methodNotAllowed      // 405
    case requestTimeout        // 408
    case conflict              // 409
    case gone                  // 410
    case preconditionFailed    // 412
    case payloadTooLarge       // 413
    case unsupportedMediaType  // 415
    case tooManyRequests       // 429
    case internalServerError   // 500
    case notImplemented        // 501
    case badGateway            // 502
    case serviceUnavailable    // 503
    case gatewayTimeout        // 504
}
