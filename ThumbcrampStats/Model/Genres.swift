import Foundation

enum Genres: String, Codable, CaseIterable {
    case ActionAdventure = "Action Adventure"
    case ActionRPG = "Action RPG"
    case Platformer2D = "2D Platformer"
    case Platformer3D = "3D Platformer"
    case RPG = "RPG"
    case Simulation = "Sim"
    case Party = "Party"
    case Adventure = "Adventure"
    case Survival = "Survival"
    case Other = "Other"
}
