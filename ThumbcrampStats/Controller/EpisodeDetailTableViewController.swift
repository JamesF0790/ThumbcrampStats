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
    var currentReviewNumber = Int()
    var reviewerCount: [Reviewers:Int] = [:]
    
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

    @IBAction func unwindToEpisodeForm(segue: UIStoryboardSegue) {
        let vc = segue.source as! ReviewTableViewController
        if episode == nil { print ("oops") }
        episode!.reviews = vc.reviews

        
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showReviews" {
            let vc = segue.destination as! ReviewTableViewController
            
            FormToEpisode()

            print ("\(vc.reviews)")
            print (episode!.reviews)
            vc.reviews = episode!.reviews
            print (vc.reviews)
            vc.episodeNumber = episode!.number
            vc.currentreviewNumber = currentReviewNumber
            vc.reviewerCount = reviewerCount
            
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
        var number = Int()
        if episode?.number != nil{
            number = episode!.number
        } else if episodeNumberField.text != nil {
            number = Int(episodeNumberField.text!) ?? 0
        }
        let date = episodeDatePicker.date
        
        var reviews: [Review] {
            if let reviews = episode?.reviews {
                return reviews
            } else {
                let empty = [Review]()
                return empty
            }
        }
//        let reviews = episode?.reviews ?? [Review]()
        var mod: Float?
        if episode?.scoreModifier != nil {
            mod = episode!.scoreModifier!
        } else if episodeScoreModifierField.text != nil {
            mod = Float(episodeScoreModifierField.text!) ?? nil
        }
        
        episode = Episode(number: number, date: date, reviews: reviews, scoreModifier: mod)
        
    }
}
