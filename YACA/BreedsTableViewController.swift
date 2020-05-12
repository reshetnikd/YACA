//
//  BreedsTableViewController.swift
//  YACA
//
//  Created by Dmitry Reshetnik on 02.05.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit

class BreedsTableViewController: UITableViewController, UISearchResultsUpdating {
    var breeds = [Breed]()
    var filteredBreeds = [Breed]()
    var isFilterActive : Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    let searchController = UISearchController(searchResultsController: nil)
    let headers = ["x-api-key": "7b7f2fab-4724-44ad-8692-a172f7af0b1d"]
    let urlString = "https://api.thecatapi.com/v1/breeds"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = "Breeds"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Setting up UISearchController.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setting up UIRefreshControl.
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)

        fetchData(from: urlString)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFilterActive ? filteredBreeds.count : breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Breed Cell", for: indexPath)
        let breed: Breed
        
        // Check if filter is active to choose from correct data model.
        if isFilterActive {
            breed = filteredBreeds[indexPath.row]
        } else {
            breed = breeds[indexPath.row]
        }

        // Configure the cell...
        cell.textLabel?.text = breed.name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Breed Detail") as? BreedDetailViewController {
            // Check if filter is active to choose from correct data model.
            if isFilterActive {
                vc.breed = filteredBreeds[indexPath.row]
            } else {
                vc.breed = breeds[indexPath.row]
            }
            
            // Show BreedDetailViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Fetching data
    
    @objc func handleRefreshControl() {
        // Update content.
        fetchData(from: urlString)

        // Dismiss the refresh control.
        DispatchQueue.main.async {
           self.refreshControl?.endRefreshing()
        }
    }
    
    func fetchData(from resource: String) {
        // Configure request.
        let request = NSMutableURLRequest(
            url: NSURL(string: resource)! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        // Configure data task to fetch data from given URL.
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.showError(error!.localizedDescription)
            } else {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Parsing each property automatically.
                do {
                    self.breeds = try decoder.decode([Breed].self, from: data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    self.showError(error.localizedDescription)
                }
            }
        })

        // Launch data task.
        dataTask.resume()
    }
    
    // MARK: - Error
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    // MARK: - Search
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredBreeds = breeds.filter { (breed) -> Bool in
            return breed.name.lowercased().contains(searchText.lowercased()) || breed.temperament.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }

}
