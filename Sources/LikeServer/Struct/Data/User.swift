//
//  User.swift
//  LikeServer
//
//  Created by Jaemin Hong on 10/26/24.
// 

import Foundation

public struct User: Identifiable, Codable, Equatable {
    public let id: Int
    public let name: String
    public let profileURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileURL = "profile_image"
    }
}
