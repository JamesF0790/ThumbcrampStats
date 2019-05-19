import UIKit

class ReviewDetailTableViewController: UITableViewController, UIPickerViewDelegate {

    var episodeNumber = Int()
    var review: Review?
    var currentReviewNumber = Int()
    var reviewerCount: [Reviewers:Int] = [:]
    
    var nameSafe = false
    
    var isReviewerPickerShown = false
    var isSystenPickerShown = false
    var isGenrePickerShown = false
    var isReviewerSet = false
    var isSystemSet = false
    var isGenreSet = false
    
    var isDeleteButtonShown: Bool = false
    var isDoneButtonEnabled: Bool = false
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var episodeNumberField: UITextField!
    @IBOutlet weak var reviewNumberField: UITextField!
    
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var reviewerPicker: UIPickerView!
    @IBOutlet weak var reviewerReviewNumber: UITextField!
    
    @IBOutlet weak var systemLabel: UILabel!
    @IBOutlet weak var systemPicker: UIPickerView!
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genrePicker: UIPickerView!
    
    @IBOutlet weak var scoreField: UITextField!
    
    @IBOutlet weak var indieSwitch: UISwitch!
    @IBOutlet weak var hornySwitch: UISwitch!
    @IBOutlet weak var hungrySwitch: UISwitch!
    @IBOutlet weak var magicSwitch: UISwitch!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        systemPicker.delegate = self
        systemPicker.dataSource = self
        
        reviewerPicker.dataSource = self
        reviewerPicker.delegate = self
        
        genrePicker.delegate = self
        genrePicker.dataSource = self
        
        reviewerLabel.textColor = tableView.tintColor
        systemLabel.textColor = tableView.tintColor
        genreLabel.textColor = tableView.tintColor
        
        if review != nil {
            isDeleteButtonShown = true
            isSystemSet = true
            isGenreSet = true
            isReviewerSet = true
            LoadUI(review!)
        }
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func nameChanged(_ sender: UITextField) {
        DoneSafeCheck()
        doneButton.isEnabled = isDoneButtonEnabled
    }
    @IBAction func episodeChanged(_ sender: UITextField) {
    }
    @IBAction func numberChanged(_ sender: UITextField) {
    }
    @IBAction func reviewerNumberChanged(_ sender: UITextField) {
        DoneSafeCheck()
        doneButton.isEnabled = isDoneButtonEnabled
    }
    @IBAction func scoreChanged(_ sender: UITextField) {
        DoneSafeCheck()
        doneButton.isEnabled = isDoneButtonEnabled
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath) {
        case [0,3]:
            isReviewerPickerShown = !isReviewerPickerShown
            
            reviewerLabel.textColor = !isReviewerPickerShown ? tableView.tintColor : .black
            
        case [0,6]:
            isSystenPickerShown = !isSystenPickerShown
            
            systemLabel.textColor = !isSystenPickerShown ? tableView.tintColor : .black
            
        case [0,8]:
            isGenrePickerShown = !isGenrePickerShown
            
            genreLabel.textColor = !isGenrePickerShown ? tableView.tintColor : .black
            
        default:
            break
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalHeight = CGFloat(44)
        let pickerHeight = CGFloat(162)
        let hiddenHeight = CGFloat(0)
        
        switch (indexPath) {
        case [0,4]:
            return isReviewerPickerShown ? pickerHeight : hiddenHeight
        case [0,7]:
            return isSystenPickerShown ? pickerHeight : hiddenHeight
        case [0,9]:
            return isGenrePickerShown ? pickerHeight : hiddenHeight
        case [0,16]:
            return isDeleteButtonShown ? normalHeight : hiddenHeight
        default:
            return normalHeight
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        FormToReview()
    }
    

}
// MARK: - Picker View
extension ReviewDetailTableViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case reviewerPicker:
            return Reviewers.allCases.count
        case systemPicker:
            return Systems.allCases.count
        case genrePicker:
            return Genres.allCases.count
        default:
            return 4
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case reviewerPicker:
            return Reviewers.allCases[row].rawValue
        case systemPicker:
            return Systems.allCases[row].rawValue
        case genrePicker:
            return Genres.allCases[row].rawValue
        default:
            let string = ["This", "Is", "An", "Error"]
            return string[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case reviewerPicker:
            let reviewer = Reviewers.allCases[row]
            reviewerLabel.text = reviewer.rawValue
            isReviewerSet = true
            guard let count = reviewerCount[reviewer] else {return}
            reviewerReviewNumber.text = String(count + 1)

        case systemPicker:
            systemLabel.text = Systems.allCases[row].rawValue
            isSystemSet = true
        case genrePicker:
            genreLabel.text = Genres.allCases[row].rawValue
            isGenreSet = true
        default:
            break
        }
    }
    
}

// MARK: - Helper Procs
extension ReviewDetailTableViewController {
    
    func DoneSafeCheck() {
        let nameSafe = !nameField.text!.isEmpty
        let reviewerNumberSafe = !reviewerReviewNumber.text!.isEmpty
        let scoreSafe = !scoreField.text!.isEmpty
        
        if nameSafe && reviewerNumberSafe && scoreSafe {
            isDoneButtonEnabled = true
        } else {
            isDoneButtonEnabled = false
        }
    }
    
    func LoadUI(_ review: Review?) {
        if let review = review {
            nameField.text = review.name
            episodeNumberField.text = String(review.episode)
            reviewNumberField.text = String(review.number)
            
            
            var reviewerIndex = Int()
            for i in 0...Reviewers.allCases.count-1 {
                if review.reviewer == Reviewers.allCases[i] {
                    reviewerIndex = i
                }
            }
            reviewerPicker.selectRow(reviewerIndex, inComponent: 0, animated: true)
            reviewerReviewNumber.text = String(review.reviewerNumber)
            var genreIndex = Int()
            for i in 0...Genres.allCases.count-1 {
                if review.genre == Genres.allCases[i] {
                    genreIndex = i
                }
            }
            genrePicker.selectRow(genreIndex, inComponent: 0, animated: true)
            
            var systemIndex = Int()
            for i in 0...Systems.allCases.count-1 {
                if review.system == Systems.allCases[i] {
                    systemIndex = i
                }
            }
            systemPicker.selectRow(systemIndex, inComponent: 0, animated: true)
            
            scoreField.text = String(review.score)
            
            indieSwitch.isOn = review.indie
            hornySwitch.isOn = review.horny
            hungrySwitch.isOn = review.hungry
            magicSwitch.isOn = review.magic
        } else {
            episodeNumberField.text = String(episodeNumber)
            reviewNumberField.text = String(currentReviewNumber + 1)
        }
    }
    
    func FormToReview() {
        let name: String = nameField.text!
        let episodeNumber = Int(episodeNumberField.text!)!
        let reviewNumber = Int(reviewNumberField.text!)!
        let reviewer = Reviewers.allCases[reviewerPicker.selectedRow(inComponent: 0)]
        let reviewerNumber = Int(reviewerReviewNumber.text!)!
        let genre = Genres.allCases[genrePicker.selectedRow(inComponent: 0)]
        let system = Systems.allCases[systemPicker.selectedRow(inComponent: 0)]
        let score = Float(scoreField.text!)!
        let indie = indieSwitch.isOn
        let horny = hornySwitch.isOn
        let hungry = hungrySwitch.isOn
        let magic = magicSwitch.isOn
        
        review = Review(name: name, episode: episodeNumber, number: reviewNumber, reviewerNumber: reviewerNumber, genre: genre, system: system, reviewer: reviewer, score: score, horny: horny, indie: indie, magic: magic, hungry: hungry)
        
    }
}
