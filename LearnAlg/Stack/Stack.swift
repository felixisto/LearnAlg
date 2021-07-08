//
//  Stack.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 23.06.21.
//

import Foundation

struct Stack <T> {
    var data: [T] = []
    
    var count: Int {
        return data.count
    }
    
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    mutating func push(_ value: T) {
        data.append(value)
    }
    
    @discardableResult
    mutating func pop() -> T {
        if data.isEmpty {
            fatalError("Popping empty stack")
        }
        
        return data.popLast()!
    }
    
    mutating func popSafely() -> T? {
        return data.popLast()
    }
}
