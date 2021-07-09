//
//  LinkedListNodeTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 8.07.21.
//

import Foundation

class LinkedListNodeTests {
    typealias Node = LinkedListNode
    
    func test() {
        print(#function)
        
        testFindCycleReference()
    }
    
    func testFindCycleReference() {
        print(#function)
        
        let a = Node(value: 0, next: nil)
        let b = Node(value: 1, next: nil)
        let c = Node(value: 2, next: nil)
        let d = Node(value: 3, next: nil)
        let e = Node(value: 4, next: nil)
        a.next = b
        b.next = c
        c.next = d
        d.next = e
        e.next = b // Retain cycle btw
        
        print("linked list: 0 -> 1 -> 2 -> 3 -> 4 -> 1 -> ...")
        
        if let cycle = a.findFirstCycleReferenceWithHashing() {
            // Correct, expected result: LAST <4 -> 1> -> FIRST <1 -> 2>
            print("linked list cycle with hashing: LAST \(cycle.last) -> FIRST \(cycle.first)")
        } else {
            print("linked list cycle with hashing: could not find cycle!")
        }
        
        print("linked list: 0 -> 1 -> 2 -> 3 -> 4 -> 1 -> ...")
        
        if let cycle = a.findFirstCycleReference() {
            // Correct, expected result: LAST <4 -> 1> -> FIRST <1 -> 2>
            print("linked list cycle with floyds cycle detection: LAST \(cycle.last) -> FIRST \(cycle.first)")
        } else {
            print("linked list cycle with floyds cycle detection: could not find cycle!")
        }
        
        e.next = nil // Break retain cycle
        
        //
        //
        //
        
        let oneNode = Node(value: 1, next: nil)
        oneNode.next = oneNode // Retain cycle btw
        
        print("linked list: 0 -> 0 -> ...")
        
        if let cycle = oneNode.findFirstCycleReferenceWithHashing() {
            // Correct, expected result: LAST <1 -> 1> -> FIRST <1 -> 1>
            print("linked list cycle with hashing: LAST \(cycle.last) -> FIRST \(cycle.first)")
        } else {
            print("linked list cycle with hashing: could not find cycle!")
        }
        
        print("linked list: 0 -> 0 -> ...")
        
        if let cycle = oneNode.findFirstCycleReference() {
            // Correct, expected result: LAST <1 -> 1> -> FIRST <1 -> 1>
            print("linked list cycle with floyds cycle detection: LAST \(cycle.last) -> FIRST \(cycle.first)")
        } else {
            print("linked list cycle with floyds cycle detection: could not find cycle!")
        }
        
        oneNode.next = nil // Break retain cycle
    }
}
