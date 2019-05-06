//
//  Formatters.swift
//  ThumbcrampStats
//
//  Created by James Frost on 6/5/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import Foundation

class Formatters {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
