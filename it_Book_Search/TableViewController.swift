//
//  TableViewController.swift
//  it_Book_Search
//
//  Created by Oleksii Kolakovskyi on 1/29/20.
//  Copyright © 2020 Aleksey. All rights reserved.
//

import UIKit


struct BookRequest {

    let resourseURL: URL
//    var bookList: Data
    
    init(bookSearch: String) {
                
        var url = "https://api.itbook.store/1.0/\(bookSearch)"
        guard let resourseURL = URL(string: url) else {fatalError()}
        
        self.resourseURL = resourseURL
        
        let task = URLSession.shared.dataTask(with: resourseURL)
        {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            print(data)
        }

        task.resume()
    }
    
}



class TableViewController: UITableViewController {
    
    var data1 = BookRequest.init(bookSearch: "new")
    var dataRecieved: BooksData?
        
    var books: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let data = data1
        self.dataRecieved = try! JSONDecoder().decode(BooksData.self, from: data)
        
    }
    
    
}
