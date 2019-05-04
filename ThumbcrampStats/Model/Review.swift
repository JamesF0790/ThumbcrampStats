//
//  Review.swift
//  ThumbcrampStats
//
//  Created by James Frost on 30/4/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import Foundation


struct Review: Codable {
    let name: String
    let episode: Int
    let number: Int
    let reviewerNumber: Int
    let genre: Genres
    let system: Systems
    let reviewer: Reviewers
    let score: Float
    let horny: Bool
    let indie: Bool
    let magic: Bool
}


extension Review {
    
    static func GetReviews(episodes: [Episode]) -> [Review] {
        var reviews: [Review] = []
        for x in episodes {
            for y in x.reviews {
                reviews.append(y)
            }
        }
        return reviews
    }
}
