import Foundation

struct Episode: Codable {
    var number: Int // This can be gotten by the count or adding 1 to the index
    var date: Date
    var reviews: [Review]
    var scoreModifier: Float?
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
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archive = documentsDirectory.appendingPathComponent("episodes").appendingPathExtension("plist")
    
    static func Save(_ episodes: [Episode]) {
        
        let encoder = PropertyListEncoder()
        let codedEpisodes = try? encoder.encode(episodes)
            try? codedEpisodes?.write(to: archive, options: .noFileProtection)

        
    }
    
    static func Load() -> [Episode]? {
        guard let codedEpisodes = try? Data(contentsOf: archive) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<Episode>.self, from: codedEpisodes)
    }
    
}

// MARK: - Helper Procs
extension Episode {
    static func Sort(_ episodes: [Episode]) -> [Episode] {
        return episodes.sorted(by: {$0.number < $1.number})
    }
}

