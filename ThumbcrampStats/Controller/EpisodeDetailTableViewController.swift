//
//  EpisodeDetailTableViewController.swift
//  ThumbcrampStats
//
//  Created by James Frost on 6/5/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import UIKit

class EpisodeDetailTableViewController: UITableViewController {

    @IBOutlet weak var episodeNumberField: UITextField!
    @IBOutlet weak var episodeBaseScoreField: UILabel!
    @IBOutlet weak var episodeScoreModifierField: UITextField!
    @IBOutlet weak var episodeFinalScoreLabel: UILabel!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if episode != nil{
            loadEpisode()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension EpisodeDetailTableViewController {
    
    func loadEpisode() {
        episodeNumberField.text = String(episode!.number)
        episodeBaseScoreField.text = "\(episode!.baseScore)/\(episode!.reviews.count * 5)"
        if episode!.scoreModifier != nil {
            episodeScoreModifierField.text = String(episode!.scoreModifier!)
        }
        episodeFinalScoreLabel.text = "\(episode!.score)/\(episode!.reviews.count * 5)"
    }
}
