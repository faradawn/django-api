//
//  Users.swift
//  Cherry Learn
//
//  Created by faradawn on 2021/6/11.
//

import Foundation

struct Users: Codable, Hashable {
    let username: String
    let email: String
    let phone: String
    let password: String
}
