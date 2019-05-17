import UIKit

class ReviewTableViewController: UITableViewController {

    var episodeNumber = Int()
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        let review = reviews[indexPath.row]
        cell.textLabel?.text = review.name
        return cell
    }
    

    // MARK: - Navigation

    @IBAction func unwindToReviewList(segue: UIStoryboardSegue) {
        let sourceVC = segue.source as! ReviewDetailTableViewController
        switch segue.identifier {
        case "saveUnwind":
            guard let review = sourceVC.review else {return}
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                reviews[selectedIndexPath.row] = review
                //Sort reviews here
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
        case "deleteUnwind":
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {return}
            reviews.remove(at: selectedIndexPath.row)
            //Sort Reviews
            tableView.deleteRows(at: [selectedIndexPath], with: .automatic)
        default:
            return
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showReview" {
            
            let vc = segue.destination as! ReviewDetailTableViewController
            let row = tableView.indexPathForSelectedRow!.row
            
            vc.review = reviews[row]
            vc.episodeNumber = episodeNumber
            
        }
    }
}

