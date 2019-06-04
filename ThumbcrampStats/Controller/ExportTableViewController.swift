//
//  ExportTableViewController.swift
//  ThumbcrampStats
//
//  Created by James Frost on 27/5/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import UIKit

class ExportTableViewController: UITableViewController {

    var episodes: [Episode]?
    var reviews: [Review]?
    var reviewers: [Reviewer]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func systemButtonTapped(_ sender: Any) {
        //SystemBreakup()
    }
    @IBAction func jsonButtonTapped(_ sender: Any) {
        JSONExport()
    }
    
}

// MARK: - CSV Funcs
extension ExportTableViewController {
    
    
    func SystemBreakup() {
        let fileName = "systems.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = "Reviewer, Systems/n"
        
        var systemlist = ",,"
        for x in Systems.allCases {
            systemlist += "\(x.rawValue),"
        }
        systemlist += "/n"
        csvText += systemlist
        
        for x in reviewers! {
            var tempText = "\(x.name),,"
            for y in Systems.allCases {
                for (system,count) in x.systems {
                    if system == y {
                        tempText += "\(count),"
                    }
                }
            }
            tempText += "/n"
            csvText += tempText
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            
            let vc = UIActivityViewController(activityItems: [path!], applicationActivities: [])
            present(vc, animated:true, completion: nil)
        } catch {
            print ("Failed to create csv")
            print ("\(error)")
        }
        
    }
    
    func JSONExport() {

        guard let episodesJSON = try? JSONEncoder().encode(episodes) else {return}
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let episodesArchive = documentsDirectory.appendingPathComponent("episodes").appendingPathExtension("json")
        

        try? episodesJSON.write(to: episodesArchive, options: .noFileProtection)
        

        let vc = UIActivityViewController(activityItems: [episodes!], applicationActivities: [])
        present(vc, animated:  true, completion: nil)
    }
        
}
