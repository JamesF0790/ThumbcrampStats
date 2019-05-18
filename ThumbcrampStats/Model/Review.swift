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
    let hungry: Bool
}

extension Review {
    
    enum sortingOptions {
        case episode
        case number
        case reviewerNumber
    }
    
    static func SortBy(_ reviews: [Review], option: sortingOptions) -> [Review] {
        
        switch option {
        case .episode:
            return reviews.sorted(by: {$0.episode < $1.episode})
        case .number:
            return reviews.sorted(by: {$0.episode < $1.episode})
        case .reviewerNumber:
            return reviews.sorted(by: {$0.reviewerNumber < $1.reviewerNumber})
        }
    }
}
