//
//  PFPosition.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 14.05.21.
//

import Foundation

class PFPosition: CustomStringConvertible, Equatable {
    var name : String

    init(name: String) {
        self.name = name
    }

    static func == (lhs: PFPosition, rhs: PFPosition) -> Bool {
        return lhs.name == rhs.name
    }

    var description: String {
        return name
    }
}
