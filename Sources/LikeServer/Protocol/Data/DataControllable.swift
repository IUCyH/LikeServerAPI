//
//  DataManageable.swift
//  LikeServer
//
//  Created by Jaemin Hong on 10/26/24.
// 

import Foundation

internal protocol DataControllable {
    func makeURL(_ parameter: GetParameter) throws -> URLComponents
    func makeResult(_ data: Data) throws -> GetResult
}
