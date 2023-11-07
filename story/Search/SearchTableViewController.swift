//
//  SearchTableViewController.swift
//  story
//
//  Created by 李彤 on 2023/10/27.
//

import UIKit
var selectedProduct = String()
class SearchTableViewController: UITableViewController {
    let songs = allArrary
    lazy var filteredSongs = songs
    var dataProvider = DataProvider()
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredSongs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SCell", for: indexPath)
        let song = filteredSongs[indexPath.row]
        cell.textLabel?.text = song
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = filteredSongs[indexPath.row]
        performSegue(withIdentifier: "goback", sender: self)
    }
}

extension SearchTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
           searchText.isEmpty == false  {
            filteredSongs = songs.filter({ song in
                song.localizedStandardContains(searchText)
            })
        } else {
            filteredSongs = songs
        }
        tableView.reloadData()
    }
}
