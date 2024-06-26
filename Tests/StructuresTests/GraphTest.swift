//
//  GraphTest.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 9/19/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import XCTest

@testable import Structures


/* 
   unit test cases specific to graph algorithms
   to test your own graph, replace the vertices and edges.
*/

class GraphTest: XCTestCase {
    

    var testGraph: Graph = Graph<String>()
    
    var vertexA = Vertex(with: "A")
    var vertexB = Vertex(with: "B")
    var vertexC = Vertex(with: "C")
    var vertexD = Vertex(with: "D")
    var vertexE = Vertex(with: "E")
    
    
    //called before each test invocation
    override func setUp() {
        super.setUp()
        
        /* add the vertices */
        
        testGraph.addVertex(element: vertexA)
        testGraph.addVertex(element: vertexB)
        testGraph.addVertex(element: vertexC)
        testGraph.addVertex(element: vertexD)
        testGraph.addVertex(element: vertexE)
        
        
        /* connect the vertices with weighted edges */
        
        testGraph.addEdge(source: vertexA, neighbor: vertexD, weight: 4)
        testGraph.addEdge(source: vertexA, neighbor: vertexB, weight: 1)
        testGraph.addEdge(source: vertexB, neighbor: vertexD, weight: 5)
        testGraph.addEdge(source: vertexB, neighbor: vertexC, weight: 2)
        testGraph.addEdge(source: vertexD, neighbor: vertexE, weight: 8)

    }
    
    
    //validate neighbor association
    func testVertexNeighbors() {
        
        neighborTest(of: vertexA, with: vertexD)
        neighborTest(of: vertexA, with: vertexB)
        neighborTest(of: vertexB, with: vertexD)
        neighborTest(of: vertexB, with: vertexC)
        neighborTest(of: vertexD, with: vertexE)
    }
    
    
    
    //find the shortest path using heapsort operations - O(1)
    func testDijkstraWithHeaps() {
        
        let sourceVertex = vertexA
        let destinationVertex = vertexE
        
        
        let shortestPath: Path! = testGraph.processDijkstraWithHeap(sourceVertex, destination: destinationVertex)
        XCTAssertNotNil(shortestPath, "shortest path not found..")
        
        printPath(shortestPath)
    }
    
    
    
    
    //find the shortest path based on two non-negative edge weights - O(n)
    func testDijkstra() {
        
        let sourceVertex = vertexA
        let destinationVertex = vertexE

        
        let shortestPath: Path! = testGraph.processDijkstra(sourceVertex, destination: destinationVertex)
        XCTAssertNotNil(shortestPath, "shortest path not found..")
        
        printPath(shortestPath)
    }

    
    //MARK: PageRank algorithms

        
    //pagerank with sinks - sink values are allocated to other vertices
    func testPageRankWithSink() {
        
        var probability: Float = 0.0
        
        testGraph.processPageRankWithSink()
        
        for v in testGraph.canvas {
            
            if let rvalue = v.rank.last {
                probability += rvalue
                print("\(v.tvalue!) pagerank is: \(rvalue)" )
            }
        }
             
        XCTAssert(probability == 100, "test failed: pagerank probability for all vertices does not equal 1")
    }
    

    
    //MARK: Closures and traversals
 
    
    //breadth-first search
    func testBFSTraverse() {
        testGraph.traverse(vertexA)
    }
    
    
    //breadth-first search with function
    func testBFSTraverseFunction() {
        testGraph.traverse(vertexA, formula: traverseFormula)
    }
    

    
    
    //breadth-first search with closure expression
    func testBFSTraverseExpression() {
        
        /*
        notes: the inout parameter is passed by reference.
        As a result, no return type is required. Also note the trailing closure syntax.
        */

        testGraph.traverse(vertexA) { ( node: inout Vertex) -> () in
            
            node.visited = true
            print("traversed vertex: \(node.tvalue!)..")
            
        }
        
        
    }
    

    
    //closure function passed as parameter
    func traverseFormula(node: inout Vertex<String>) -> () {
        
        /*
        notes: the inout parameter is passed by reference. 
        As a result, no return type is required.
        */
        
        node.visited = true
        print("traversed vertex: \(node.tvalue!)..")
    }

    
    
    
    //MARK: - Helper function
    
    
    //check for membership
    func neighborTest(of source: Vertex<String>, with neighbor: Vertex<String>) {

        
        //add unvisited vertices to the queue
        for e in source.neighbors {
            if (e.neighbor.tvalue == neighbor.tvalue) {
                return
            }
        }
        
        XCTFail("vertex \(neighbor.tvalue!) is not a neighbor of vertex \(source.tvalue!)")
        
    }
    
    
    //reverse a path data structure
    func printPath(_ shortestPath: Path<String>!) {

        
        var reversedPath: Path! = Path<String>()
        var current: Path! = Path<String>()
        
        
        //reverse the sequence of paths
        reversedPath = testGraph.reversePath(shortestPath, source: vertexA)
        current = reversedPath
        
        
        //iterate and print each path sequence
        while (current != nil) {
            print("The path is : \(current.destination.tvalue!) with a total of : \(current.total)..")
            current = current.previous
        }

        
        
    }
  
    
    
} //end class
