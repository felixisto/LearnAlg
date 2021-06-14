//
//  PFPath.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 14.05.21.
//

import Foundation

class PFPath: CustomStringConvertible {
    var from: PFPosition
    var to: PFPosition
    var distance: Int
    var bidirectional: Bool

    init(from: PFPosition, to: PFPosition, distance: Int = 1, bidirectional: Bool = true) {
        self.from = from
        self.to = to
        self.distance = distance
        self.bidirectional = bidirectional
    }

    var reversedPath: PFPath {
        get {
            PFPath(from: to, to: from, distance: distance, bidirectional: bidirectional)
        }
    }

    var description: String {
        return "\(from.name) -> \(to.name)"
    }
}
