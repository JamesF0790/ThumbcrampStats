//
//  EpisodeTableViewController.swift
//  ThumbcrampStats
//
//  Created by James Frost on 5/5/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import UIKit

class EpisodeTableViewController: UITableViewController {

    var episodes: [Episode] = []
    var reviews: [Review] = []
    var reviewers: [Reviewer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviews = CollectReviews(episodes)
        reviewers = CreateReviewers(reviews)
        
        // Load the episodes from JSON here.

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodes.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EpisodeTableViewController {
    func CollectReviews(_ episodes: [Episode]) -> [Review] {
        var temp: [Review] = []
        for x in episodes {
            for y in x.reviews {
                temp.append(y)
            }
        }
        return temp
    }
    
    
    func CreateReviewers(_ reviews: [Review]) -> [Reviewer] {
        var tempReviewers: [Reviewer] = []
        var reviewerNames: [Reviewers] = []
        for x in reviews {
            if !reviewerNames.contains(x.reviewer) {
                reviewerNames.append(x.reviewer)
            }
        }
        for name in reviewerNames {
            var tempReviews: [Review] = []
            for x in reviews {
                if x.reviewer == name {
                    tempReviews.append(x)
                }
            }
            tempReviewers.append(Reviewer(name: name, reviews: tempReviews))
        }
        return tempReviewers
    }
    
}
