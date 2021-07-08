//
//  BinarySearchTreeBasicTests.swift
//  LearnAlg
//
//  Created by Kristiyan Butev on 5.06.21.
//

import Foundation

class TestBinarySearchTree {
    func test() {
        print("test1()")
        test1()
        
        print("test2()")
        test2()
        
        print("testBuildBSTFromArray()")
        testBuildBSTFromArray()
        
        testTraversal()
        testInsert()
    }
    
    func test1() {
        let tree1 = BinarySearchTree(value: 7)
        tree1.makeLeftChild(withValue: 3)
        tree1.makeRightChild(withValue: 10)
        tree1.left?.makeLeftChild(withValue: 1)
        tree1.left?.makeRightChild(withValue: 5)
        tree1.left?.right?.makeLeftChild(withValue: 2)
        tree1.right?.makeRightChild(withValue: 11)
        
        print("tree1:\n\(tree1)")
        
        // Expected output: true
        print("tree1 contains 5: \(tree1.contains(value: 5))")
        
        // Expected output: false
        print("tree1 contains 9: \(tree1.contains(value: 9))")
        
        // Expected output: 4
        print("tree1 height: \(tree1.height)")
        
        // Expected output: 6
        print("tree1 count: \(tree1.count)")
        
        print("tree1:\n\(tree1)")
        
        print("inserting value 9 into tree1")
        tree1.insert(value: 9)
        
        // Expected output: true
        print("tree1 contains 9: \(tree1.contains(value: 9))")
        
        // Expected output: 4
        print("tree1 height: \(tree1.height)")
        
        // Expected output: 7
        print("tree1 count: \(tree1.count)")
        
        print("tree1:\n\(tree1)")
        
        // Expected output: false
        print("tree1 contains 8: \(tree1.contains(value: 8))")
        
        print("inserting value 8 into tree1")
        tree1.insert(value: 8)
        
        // Expected output: true
        print("tree1 contains 8: \(tree1.contains(value: 8))")
        
        // Expected output: 5
        print("tree1 height: \(tree1.height)")
        
        // Expected output: 8
        print("tree1 count: \(tree1.count)")
        
        print("tree1:\n\(tree1)")
    }
    
    func test2() {
        let tree2 = BinarySearchTree(value: 7)
        tree2.makeLeftChild(withValue: 3)
        tree2.makeRightChild(withValue: 10)
        tree2.left?.makeLeftChild(withValue: 1)
        tree2.left?.makeRightChild(withValue: 5)
        tree2.left?.right?.makeLeftChild(withValue: 2)
        tree2.right?.makeRightChild(withValue: 11)
        
        print("tree2:\n\(tree2)")
        
        // Expected output: 4
        print("tree2 height: \(tree2.height)")
        
        // Expected output: true
        print("tree2 contains 3: \(tree2.contains(value: 3))")
        
        print("tree2: delete value 3")
        tree2.delete(value: 3)
        
        print("tree2:\n\(tree2)")
        
        // Expected output: false
        print("tree2 contains 3: \(tree2.contains(value: 3))")
        
        // Expected output: 4
        print("tree2 height: \(tree2.height)")
        
        print("tree2: delete value 11")
        tree2.delete(value: 11)
        
        print("tree2:\n\(tree2)")
    }
    
    func testBuildBSTFromArray() {
        let array1 = [15, 10, 20, 8, 12, 18, 25]
        var tree = BinarySearchTree(from: array1)
        print("make tree from array \(array1) ---> \(tree)")
        print("is BST? \(tree.isBinarySearchTree)")
        
        let array2 = [7, 3, 10, 1, 5, 2, 11]
        tree = BinarySearchTree(from: array2)
        print("make tree from array \(array2) ---> \(tree)")
        print("is BST? \(tree.isBinarySearchTree)")
    }
    
    func testTraversal() {
        let array1 = [15, 10, 20, 8, 12, 18, 25]
        let tree = BinarySearchTree(from: array1)
        
        // Expected result: ((8) <- 10 -> (12)) <- 15 -> ((18) <- 20 -> (25))
        print("tree = \(tree)")
        
        // Expected result: [8, 10, 12, 15, 18, 20, 25]
        print("in order tree = \(tree.accumulateAll(order: .inOrder))")
        
        // Expected result: [15, 10, 8, 12, 20, 18, 25]
        print("pre order tree = \(tree.accumulateAll(order: .preOrder))")
        
        // Expected result: [8, 12, 10, 18, 25, 20, 15]
        print("post order tree = \(tree.accumulateAll(order: .postOrder))")
        
        // Expected result: [8, 10, 12, 15, 18, 20, 25]
        print("in order tree = \(tree._accumulateAll_Iterative(order: .inOrder))")
        
        // Expected result: [15, 10, 8, 12, 20, 18, 25]
        print("pre order tree = \(tree._accumulateAll_Iterative(order: .preOrder))")
        
        // Expected result: [8, 12, 10, 18, 25, 20, 15]
        print("post order tree = \(tree._accumulateAll_Iterative(order: .postOrder))")
    }
    
    func testInsert() {
        let array1 = [15, 10, 20, 8, 12, 18, 25]
        let tree = BinarySearchTree(from: array1)
        
        // Expected result: ((8) <- 10 -> (12)) <- 15 -> ((18) <- 20 -> (25))
        print("tree = \(tree)")
        print("tree = \(tree.accumulateAll(order: .inOrder))")
        
        print("insert 27")
        tree.insert(value: 27)
        
        // Expected result: ((8) <- 10 -> (12)) <- 15 -> ((18) <- 20 -> (25 -> (27)))
        print("tree = \(tree)")
        print("tree = \(tree.accumulateAll(order: .inOrder))")
        
        print("insert 26")
        tree._insertNonRecursive(value: 26)
        
        // Expected result: ((8) <- 10 -> (12)) <- 15 -> ((18) <- 20 -> (25 -> ((26) <- 27)))
        print("tree = \(tree)")
        print("tree = \(tree.accumulateAll(order: .inOrder))")
    }
}
