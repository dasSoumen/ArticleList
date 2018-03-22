//
//  NYTMostViewedViewController.swift
//  NYTimesArticles
//
//  Created by Soumen Das on 21/03/18.
//  Copyright © 2018 NYTimes. All rights reserved.
//

import UIKit

class NYTMostViewedViewController: NYTBaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Instance Variable
    private var arrayArticles = [NYTArticle]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NY Times Most Popular"
        // TableView Setup
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        self.requestForMostViewedArticleList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails") {
            let controller = (segue.destination as! NYTDetailsViewController)
            controller.newsURL = arrayArticles[(sender as! Int)].newsURL
        }
    }
}

// MARK: - API Call
private typealias APIOperation = NYTMostViewedViewController
extension APIOperation {
    private func requestForMostViewedArticleList() {
        NYTRequestCoordinator.coordinator.getMostPopularArticles(withSuccess: { (response) in
            self.arrayArticles = response!
            // Hide no data label incase it is showing already.
            self.tableView.hideNoDataLabel()
            guard self.arrayArticles.count > 0 else {
                //show no data label
                self.tableView.showNodataLabelWithText(noData)
                self.tableView.reloadData()
                return
            }
            self.tableView.reloadData()
        }, andFailure: { (error) in
            debugPrint("error - \(String(describing: error))")
        })
    }
}

// MARK: - TableView Datasource & Delegate
private typealias TableViewConfiguration = NYTMostViewedViewController
extension TableViewConfiguration: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NYTMostViewedTableViewCell.name) as! NYTMostViewedTableViewCell
        cell.datasource = arrayArticles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetails", sender: indexPath.row);
    }
}

