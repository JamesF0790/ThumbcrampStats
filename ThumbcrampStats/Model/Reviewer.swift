//
//  Reviewer.swift
//  ThumbcrampStats
//
//  Created by James Frost on 30/4/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import Foundation

enum Reviewers: String, Codable {
    case Jackson
    case Joel
    case JD
}
struct Reviewer: Codable {
    let name: Reviewers
    var reviews: [Review]
    var systems: [System]
    var count: Int {
        get {
            return reviews.count
        }
    } //Gets the count from the reviews.count
    var horny: Int {
        get {
            var temp: Int = 0
            for x in reviews {
                if x.horny {
                    temp += 1
                }
            }
            return temp
        }
    } //Gets his and the Indie from checking all reviews and incrementing for each with the bool true
    var indie: Int {
        get {
            var temp: Int = 0
            for x in reviews {
                if x.indie {
                    temp += 1
                }
            }
            return temp
        }
    }
    var average: Float {
        get {
            var f: Float = 0
            for x in reviews {
                f += x.score
            }
            f /= Float(count)
            return f
        }
    }//Gets the total review score and divides it by the amount of reviews
}
