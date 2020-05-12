//
//  ImagesTableViewController.swift
//  YACA
//
//  Created by Dmitry Reshetnik on 12.05.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController {
    var images = [Image]()
    let headers = ["x-api-key": "7b7f2fab-4724-44ad-8692-a172f7af0b1d"]
    let urlString = "https://api.thecatapi.com/v1/images/search?limit=100"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "Images"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData(from: urlString)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Image Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = images[indexPath.row].url

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UITableViewCell {
            if segue.identifier == "Show Image" {
                if let imageViewController = segue.destination.contents as? ImageViewController {
                    imageViewController.imageURL = URL(string: (cell.textLabel?.text)!)
                    imageViewController.hidesBottomBarWhenPushed = true
                }
            }
        }
    }
    
    // MARK: - Fetching data
    
    func fetchData(from resource: String) {
        let request = NSMutableURLRequest(
            url: NSURL(string: resource)! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.showError(error!.localizedDescription)
            } else {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    self.images = try decoder.decode([Image].self, from: data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    self.showError(error.localizedDescription)
                }
            }
        })

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

}

extension UIViewController {
    var contents: UIViewController {
        if let navigationController = self as? UINavigationController {
             return navigationController.visibleViewController ?? self
        } else {
            return self
        }
    }
}
