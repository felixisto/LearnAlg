//
//  PathFindGraphWeightless.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 14.05.21.
//

import Foundation

class WeightlessGraphNode: Hashable, Equatable, CustomStringConvertible {
    var name: String
    var neighbours: [WeightlessGraphNode] = []
    
    init(name: String) {
        self.name = name
    }
    
    var description: String {
        return "'\(name)'"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func ==(left: WeightlessGraphNode, right: WeightlessGraphNode) -> Bool {
        return left.name == right.name
    }
}

struct WeightlessGraphNodeEdge: Hashable, Equatable, CustomStringConvertible {
    var isSource: Bool
    var source: WeightlessGraphNode
    var destination: WeightlessGraphNode
    
    init(source: WeightlessGraphNode) {
        self.isSource = true
        self.source = source
        self.destination = source
    }
    
    init(source: WeightlessGraphNode, destination: WeightlessGraphNode) {
        self.isSource = false
        self.source = source
        self.destination = destination
    }
    
    var description: String {
        return "\(source.name) -> \(destination.name)"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
    }
    
    static func ==(left: WeightlessGraphNodeEdge, right: WeightlessGraphNodeEdge) -> Bool {
        return left.source == right.source && left.destination == right.destination
    }
}

class PathFindGraphWeightless {
    func test() {
        print(#function)
        
        let a1 = WeightlessGraphNode(name: "1")
        let a2 = WeightlessGraphNode(name: "2")
        let a3 = WeightlessGraphNode(name: "3")
        let a4 = WeightlessGraphNode(name: "4")
        let a5 = WeightlessGraphNode(name: "5")
        let a6 = WeightlessGraphNode(name: "6")
        let a7 = WeightlessGraphNode(name: "7")
        //let a8 = WeightlessGraphNode(name: "8")
        
        a1.neighbours.append(a2)
        a1.neighbours.append(a3)
        
        a2.neighbours.append(a1)
        a2.neighbours.append(a3)
        a2.neighbours.append(a4)
        
        a4.neighbours.append(a2)
        
        a3.neighbours.append(a1)
        a3.neighbours.append(a2)
        a3.neighbours.append(a5)
        
        a5.neighbours.append(a3)
        a5.neighbours.append(a6)
        a5.neighbours.append(a7)
        
        a6.neighbours.append(a5)
        a6.neighbours.append(a7)
        
        a7.neighbours.append(a5)
        a7.neighbours.append(a6)
        //a7.neighbours.append(a8)
        
        //a8.neighbours.append(a7)
        
        let nodes = [a1, a2, a3, a4, a5, a6, a7]
        
        let finder = BreadthPathFind(nodes: nodes)
        print("path from a4 to a7: \(finder.path(from: a3, to: a7))")
        print("distances from a3: \(finder.distances(startingFrom: a3))")
    }
}

class BreadthPathFind {
    private var _nodes: [WeightlessGraphNode]
    
    init(nodes: [WeightlessGraphNode]) {
        self._nodes = nodes
    }
    
    func path(from: WeightlessGraphNode, to destination: WeightlessGraphNode) -> [WeightlessGraphNodeEdge] {
        let queue = PFQueue<WeightlessGraphNode>()
        var visited: [WeightlessGraphNode:WeightlessGraphNodeEdge] = [:]
        
        print("starting with '\(from.name)'")
        queue.queue(from)
        visited[from] = WeightlessGraphNodeEdge(source: from)
        
        var currentNode = from
        
        while !queue.isEmpty {
            currentNode = queue.dequeue()
            
            // Reached destination, return the shortest path
            if currentNode == destination {
                var currentNode = destination
                var route : [WeightlessGraphNodeEdge] = []
                
                // Think of this as if we are going back
                while let visit = visited[currentNode], !visit.isSource {
                    route = [visit] + route
                    currentNode = visit.source
                }
                
                return route
            }
            
            // Visit each neighbour
            for neighbour in currentNode.neighbours {
                if visited[neighbour] != nil {
                    continue
                }
                
                visited[neighbour] = WeightlessGraphNodeEdge(source: currentNode, destination: neighbour)
                
                print("visiting '\(neighbour.name)'")
                
                queue.queue(neighbour)
            }
        }
        
        return []
    }
    
    func distances(startingFrom from: WeightlessGraphNode) -> [WeightlessGraphNode:Int] {
        let queue = PFQueue<WeightlessGraphNode>()
        var visited: [WeightlessGraphNode:Bool] = [:]
        var distance: [WeightlessGraphNode:Int] = [:]
        
        print("starting with '\(from.name)'")
        queue.queue(from)
        visited[from] = true
        
        var currentNode = from
        
        while !queue.isEmpty {
            currentNode = queue.dequeue()
            
            // Visit each neighbour
            for neighbour in currentNode.neighbours {
                if visited[neighbour] != nil {
                    continue
                }
                
                visited[neighbour] = true
                
                print("visiting '\(neighbour.name)'")
                
                queue.queue(neighbour)
                
                let currentDistance = distance[currentNode] ?? 0
                let neighbourDistance = distance[neighbour] ?? 0
                
                distance[neighbour] = neighbourDistance + currentDistance + 1
            }
        }
        
        return distance
    }
}

