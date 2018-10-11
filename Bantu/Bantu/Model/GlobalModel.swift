//
//  GlobalModel.swift
//  Bantu
//
//  Created by Steven Muliamin on 11/10/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation

struct GlobalSession{
    static let session = URLSession(configuration: .default)
    static var rootUrl = "https://bantuapp.online/public"
}
