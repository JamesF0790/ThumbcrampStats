//
//  Episode.swift
//  ThumbcrampStats
//
//  Created by James Frost on 30/4/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let number: Int
    let reviews: [Review]
    let scoreModifier: Float?
    var score: Float {
        get {
            var score: Float = 0
            for x in reviews {
                score += x.score
            }
            guard let mod = scoreModifier else { return score }
            return score + mod
        }
    }
    
}
