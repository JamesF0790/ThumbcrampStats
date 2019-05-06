//
//  EpisodeTableViewController.swift
//  ThumbcrampStats
//
//  Created by James Frost on 5/5/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import UIKit

class EpisodeTableViewController: UITableViewController {


    //MARK: - Properties
    var episodes: [Episode] = []
    var reviews: [Review] = []
    var reviewers: [Reviewer] = []
    
    let formatters = Formatters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodes = LoadEpisodeSample()
        tableView.reloadData()
        reviews = CollectReviews(episodes)
        reviewers = CreateReviewers(reviews)
        
        // Load the episodes from JSON here.

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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
        let episode = episodes[indexPath.row]
        
        cell.textLabel?.text = "Episode # \(episode.number)"
        cell.detailTextLabel?.text = "\(Formatters.dateFormatter.string(from: episode.date))"
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetails" {
            let destination = segue.destination as! EpisodeDetailTableViewController
            destination.episode = episodes[tableView.indexPathForSelectedRow!.row]
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
// MARK: - Extension Funcs
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
    
    func LoadEpisodeSample() -> [Episode] {
        var temp: [Episode] = []
        let review = Review(name: "Test", episode: 1, number: 1, reviewerNumber: 1, genre: .ActionRPG, system: .gcn, reviewer: .Adam, score: 10, horny: false, indie: true, magic: false)
        let episode = Episode(number: 1, date: Date(), reviews: [review], scoreModifier: nil)
        temp.append(episode)
        return temp
    }
}
