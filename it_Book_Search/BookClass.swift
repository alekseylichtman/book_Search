//
//  BookClass.swift
//  it_Book_Search
//
//  Created by Oleksii Kolakovskyi on 1/29/20.
//  Copyright © 2020 Aleksey. All rights reserved.
//

import Foundation

struct Data: Codable {
    var error: String
    var total: String
    var books: [Book]
}

struct Book: Codable {
    var title: String
    var subtitle: String
    var isbn13: String
    var price: String
    var image: String
    var url: String
    
}
