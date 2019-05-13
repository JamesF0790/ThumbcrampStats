import UIKit

class EpisodeDetailTableViewController: UITableViewController {

    //let formatters = Formatters()
    
    @IBOutlet weak var episodeNumberField: UITextField!
    @IBOutlet weak var episodeBaseScoreField: UILabel!
    @IBOutlet weak var episodeScoreModifierField: UITextField!
    @IBOutlet weak var episodeFinalScoreLabel: UILabel!
    @IBOutlet weak var episodeDateLabel: UILabel!
    @IBOutlet weak var episodeDatePicker: UIDatePicker!
    
    var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if episode != nil{
            loadEpisode()
        }
    }

    @IBAction func episodeDatePickerChanged(_ sender: Any) {
        episodeDateLabel.text = Formatters.dateFormatter.string(from: episodeDatePicker.date)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Reviews" {
            let vc = segue.destination as! ReviewTableViewController
            if episode == nil {
                FormToEpisode()
            }
            vc.reviews = episode!.reviews
            vc.episodeNumber = episode!.number
            
        }
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
    func FormToEpisode() {
        
    }
}
