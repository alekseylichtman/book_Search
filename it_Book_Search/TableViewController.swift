//
//  TableViewController.swift
//  it_Book_Search
//
//  Created by Oleksii Kolakovskyi on 1/29/20.
//  Copyright © 2020 Aleksey. All rights reserved.
//

import UIKit


class BookRequest {
    
    let resourseURL: URL

    
    init(bookSearch: String) {
        
        var url = "https://api.itbook.store/1.0/\(bookSearch)"
        guard let resourseURL = URL(string: url) else {fatalError()}
        
        self.resourseURL = resourseURL
        
        let task = URLSession.shared.dataTask(with: resourseURL)
        {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
}

class TableViewController: UITableViewController {
    
    var dataRecieved: BooksData?
    var dataToParse: Data!
    var searchRequest = "new"
    
    
    var books: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var request = BookRequest(bookSearch: searchRequest)

        let data = dataToParse
        self.dataRecieved = try! JSONDecoder().decode(BooksData.self, from: data!)
        print(dataRecieved)
        
    }
    
    
}
