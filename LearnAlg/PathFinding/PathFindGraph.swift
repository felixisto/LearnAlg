//
//  PathFindGraph.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 14.05.21.
//

import Foundation

class PathFindGraph {
    func test() {
        print(#function)
        
        let a = PFPosition(name: "A")
        let b = PFPosition(name: "B")
        let c = PFPosition(name: "C")
        let d = PFPosition(name: "D")
        let e = PFPosition(name: "E")
        
        let paths = [
            PFPath(from: a, to: b, distance: 6),
            PFPath(from: a, to: d, distance: 1),
            PFPath(from: d, to: b, distance: 2),
            PFPath(from: d, to: e, distance: 1),
            PFPath(from: b, to: d, distance: 2),
            PFPath(from: b, to: e, distance: 2),
            PFPath(from: e, to: c, distance: 5),
            PFPath(from: e, to: b, distance: 5),
        ]
        
        let finder = PFGraph(paths: paths)
        let shortest = finder.shortestPath(from: a, to: c)
        print("shortest distance a to c: \(shortest)")
    }
}

class PFPositionNode: Hashable {
    let position: PFPosition
    
    var name: String {
        return position.name
    }
    
    weak var parent: PFPositionNode?
    var distanceWeight: Int?
    var outpaths: [PFPathNode] = []
    
    init(position: PFPosition) {
        self.position = position
    }
    
    static func == (lhs: PFPositionNode, rhs: PFPositionNode) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class PFPathNode {
    let from: PFPositionNode
    let to: PFPositionNode
    let distance: Int
    let bidirectional: Bool
    
    init(from: PFPositionNode, to: PFPositionNode, distance: Int = 1, bidirectional: Bool = true) {
        self.from = from
        self.to = to
        self.distance = distance
        self.bidirectional = bidirectional
    }
    
    var reversedPath: PFPathNode {
        get {
            PFPathNode(from: to, to: from, distance: distance, bidirectional: bidirectional)
        }
    }
}

class PFGraph {
    private var _paths: [PFPath]
    
    init(paths: [PFPath]) {
        self._paths = paths
    }

    func shortestPath(from: PFPosition, to: PFPosition) -> [PFPosition] {
        let paths: [PFPathNode] = positionNodes(from: _paths)
        
        let fromNode = positionNode(for: from, in: paths)
        let toNode = positionNode(for: to, in: paths)
        
        return _shortestPath(in: paths, from: fromNode, to: toNode).map { (node) -> PFPosition in
            return node.position
        }
    }
    
    private func _shortestPath(in paths: [PFPathNode], from: PFPositionNode, to: PFPositionNode) -> [PFPositionNode] {
        if from === to {
            return [from]
        }

        for path in paths {
            path.from.outpaths.append(path)
            if (path.bidirectional) {
                path.to.outpaths.append(path.reversedPath)
            }
        }

        from.distanceWeight = 0

        var queue = [from]

        while queue.count > 0 {
            let current = queue.removeFirst()

            for e in current.outpaths {
                let dest = e.to

                // Skip comparisons with self
                if current.name == dest.name {
                    continue
                }

                let currWeight = current.distanceWeight ?? 0

                // If the destination weight is higher than current + distance, SKIP
                // Lower weight is better, we dont want to replace lower with higher
                let newWeight = currWeight + e.distance
                
                if let destWeight = dest.distanceWeight,
                   destWeight <= newWeight {
                    print("SKIP current = \(current.name) dest = \(dest.name) weight=\(dest.distanceWeight!)")
                    continue
                }
                
                dest.distanceWeight = newWeight
                dest.parent = current
                queue.append(dest)
                
                print("current = \(current.name) weight=\(currWeight) dest = \(dest.name) weight=\(dest.distanceWeight!)")
            }
        }

        // Build the shortest path of the picked nodes
        var top : PFPositionNode? = to
        var result: [PFPositionNode] = []

        while let t = top {
            result.insert(t, at: 0)
            top = t.parent
        }

        if result.count <= 1 {
            return []
        }

        return result
    }
    
    private func positionNodes(from paths: [PFPath]) -> [PFPathNode] {
        var data: [PFPathNode] = []
        var positions = Set<PFPositionNode>()
        
        let positionForName = { (name: String) -> PFPositionNode? in
            return positions.first { (el: PFPositionNode) -> Bool in
                return el.name == name
            }
        }
        
        for path in paths {
            var from = PFPositionNode(position: path.from)
            var to = PFPositionNode(position: path.to)
            positions.insert(from)
            positions.insert(to)
            
            from = positionForName(from.name)!
            to = positionForName(to.name)!
            
            data.append(PFPathNode(from: from, to: to, distance: path.distance, bidirectional: path.bidirectional))
        }
        
        return data
    }
    
    private func positionNode(for position: PFPosition, in paths: [PFPathNode]) -> PFPositionNode {
        for path in paths {
            if path.from.name == position.name {
                return path.from
            }
            
            if path.to.name == position.name {
                return path.to
            }
        }
        
        return PFPositionNode(position: position)
    }
}
