//
//  Episode.swift
//  ThumbcrampStats
//
//  Created by James Frost on 30/4/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let number: Int // This can be gotten by the count or adding 1 to the index
    let date: Date
    let reviews: [Review]
    let scoreModifier: Float?
    var baseScore: Float {
        get {
            var score: Float = 0
            for x in reviews {
                score += x.score
            }
            return score
        }
    }
    var score: Float {
        get {
            let score = baseScore
            guard let mod = scoreModifier else { return score }
            return score + mod
        }
    }
    
}

// MARK: - Codable Extension
extension Episode {
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    static func saveEpisodes(_ episodes: [Episode]) {
        
    }

}

