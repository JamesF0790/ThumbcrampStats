//
//  HelperProcs.swift
//  ThumbcrampStats
//
//  Created by James Frost on 30/4/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import Foundation

class HelperProcs {
    
    static func loadSystems() -> [System] {
        var systems = [System]()
        let ps4 = System(name: .ps4, count: 0)
        let gamecube = System(name: .gcn, count: 0)
        let pc = System(name: .pc, count: 0)
        systems.append(ps4)
        systems.append(gamecube)
        systems.append(pc)
        return systems
    }
}
