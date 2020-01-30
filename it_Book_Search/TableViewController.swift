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
    var viewController: TableViewController
    
    init(bookSearch: String, viewController: TableViewController) {
        
        var url = "https://api.itbook.store/1.0/search/\(bookSearch)"
        guard let resourseURL = URL(string: url) else {fatalError()}
        
        self.resourseURL = resourseURL
        self.viewController = viewController
        let task = URLSession.shared.dataTask(with: resourseURL)
        {(data, response, error) in
            guard let data = data else { return }
           // print(String(data: data, encoding: .utf8)!)
            viewController.parseData(data: data)
        }
        task.resume()
        viewController.tableView.reloadData()
    }
    
}

class TableViewController: UITableViewController {
    
    var booksData: BooksData?
    var searchRequest = "new"
    var request: BookRequest!
    var books: Book?

    
    
    @IBOutlet weak var searchField: UITextField!
    

    @IBAction func searchButtonTapped(_ sender: Any) {
        searchRequest = searchField.text ?? "new"
        requestData()
       // tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return booksData?.books.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.titleLabel.text = booksData?.books[indexPath.row].title
        cell.subtitleLabel.text = booksData?.books[indexPath.row].subtitle
        cell.priceLabel.text = booksData?.books[indexPath.row].price
        cell.isbn13.text = booksData?.books[indexPath.row].isbn13
        
        return cell
    }
    
    func parseData(data: Data) {
        self.booksData = try! JSONDecoder().decode(BooksData.self, from: data)
        tableView.reloadData()
    }
    
    
    func requestData(){
        self.request = BookRequest(bookSearch: searchRequest, viewController: self)

    }
}
