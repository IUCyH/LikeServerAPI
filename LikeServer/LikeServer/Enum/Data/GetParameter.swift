//
//  GetParameter.swift
//  LikeServer
//
//  Created by Jaemin Hong on 10/26/24.
// 

import Foundation

public enum GetParameter {
    /**
     ID가 정확하게 일치하는 유저를 얻어옵니다.
     */
    case userWithID(id: String)
    /**
     유저의 이름 중 name이 포함되어 있다면 모두 얻어옵니다.
     */
    case userWithName(name: String)
}
