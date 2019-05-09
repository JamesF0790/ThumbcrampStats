import Foundation

enum Reviewers: String, Codable {
    case Jackson
    case Joel
    case JD
    case Adam
    case Cass
}
struct Reviewer: Codable {
    let name: Reviewers
    var reviews: [Review]
    var systems: [Systems:Int] {
        var temp: [Systems:Int] = [:]
        var tempSystems: [Systems] = []
        for x in reviews {
            if !tempSystems.contains(x.system) {
                tempSystems.append(x.system)
            }
        }
        for system in tempSystems {
            var count = Int()
            for x in reviews {
                if x.system == system {
                    count += 1
                }
            }
            temp[system] = count
        }
        return temp
    } // Gets the systems by looping through the reviews
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
    } //Checks a bool and how many times it appears
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
    var magic: Int {
        var i: Int = 0
        for x in reviews {
            if x.magic {
                i += 1
            }
        }
        return i
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

extension Reviewer {
    mutating func Sort() {
        reviews = reviews.sorted(by: {$0.reviewerNumber < $1.reviewerNumber})
    }
}
