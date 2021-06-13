//
//  Users.swift
//  Cherry Learn
//
//  Created by faradawn on 2021/6/11.
//

import Foundation

struct Users: Codable, Hashable, Identifiable {
    let id: Int
    var username: String
    var email: String
    var phone: String
    var password: String
}
