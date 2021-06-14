//
//  PFQueue.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 14.05.21.
//

import Foundation

class PFQueue <T> {
    private var _data: [T] = []
    
    var isEmpty: Bool {
        return _data.isEmpty
    }
    
    func queue(_ value: T) {
        _data.append(value)
    }
    
    func dequeue() -> T {
        return _data.remove(at: 0)
    }
}
