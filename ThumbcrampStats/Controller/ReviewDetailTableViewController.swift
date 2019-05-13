import UIKit

class ReviewDetailTableViewController: UITableViewController, UIPickerViewDelegate {

    var episodeNumber = Int()
    var review: Review?
    
    var isReviewerPickerShown = false
    var isSystenPickerShown = false
    var isGenrePickerShown = false
    
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
    
    @IBOutlet weak var indieSwitch: UILabel!
    @IBOutlet weak var hornySwitch: UILabel!
    @IBOutlet weak var hungrySwitch: UILabel!
    @IBOutlet weak var magicSwitch: UILabel!
    
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
    }
    
    
    // MARK: - Actions
    
    
    
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
        default:
            return normalHeight
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
            reviewerLabel.text = Reviewers.allCases[row].rawValue
        case systemPicker:
            systemLabel.text = Systems.allCases[row].rawValue
        case genrePicker:
            genreLabel.text = Genres.allCases[row].rawValue
        default:
            break
        }
    }
    
}
