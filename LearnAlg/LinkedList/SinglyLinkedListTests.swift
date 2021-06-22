//
//  SinglyLinkedListTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 22.06.21.
//

import Foundation

class SinglyLinkedListTests {
    func test() {
        testInsert()
        testCopy()
        testCopyAndDelete()
    }
    
    func testInsert() {
        var list = SinglyLinkedList<String>()
        
        list.append("a")
        list.append("c")
        
        print("list[0] = \(list[0])")
        print("list[1] = \(list[1])")
        
        list.insert("b", at: 1)
        
        print("list[0] = \(list[0])")
        print("list[1] = \(list[1])")
        print("list[2] = \(list[2])")
    }
    
    func testCopy() {
        var list = SinglyLinkedList<String>()
        
        list.append("a")
        list.append("b")
        list.append("c")
        list.append("d")
        
        let listCopyA = list.copy()
        
        print("list = \(list)")
        print("listCopyA = \(listCopyA)")
    }
    
    func testCopyAndDelete() {
        var list = SinglyLinkedList<String>()
        
        list.append("a")
        list.append("b")
        list.append("c")
        list.append("d")
        
        var listCopyA = list.copy()
        
        print("list = \(list)")
        print("listCopyA = \(listCopyA)")
        
        listCopyA.delete(at: 0)
        
        print("delete node at 0")
        print("listCopyA = \(listCopyA)")
        
        listCopyA.delete(at: 1)
        
        print("delete node at 1")
        print("listCopyA = \(listCopyA)")
        
        listCopyA.insert("e", at: 2)
        
        print("insert 'e' at 2")
        print("listCopyA = \(listCopyA)")
    }
}
