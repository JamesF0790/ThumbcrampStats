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
