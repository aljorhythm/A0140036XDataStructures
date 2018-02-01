//
//  BFSPG.swift
//  DataStructuresTests
//
//  Created by Joel Lim on 31/1/18.
//  Copyright © 2018 NUS CS3217. All rights reserved.
//

import XCTest
@testable import DataStructures

class BFSPGTests: XCTestCase {

	typealias BFSPG = BreadthFirstShortestPathGenerator
	
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testShortestPath() {
        let graphFileName = "graph_simple_bfs_shortest"
        guard let graph = BreadthFirstOrderGeneratorTests.getGraph(graphFileName) else {
            XCTFail("Path not found")
            return
        }
        guard let shortestPath = BFSPG(graph: graph, start: "A", end: "D") else {
            XCTFail("Error finding shortest path")
            return
        }
        XCTAssertEqual(Array(shortestPath), ["A", "C", "D"], "The  shortest path for \(graphFileName) is wrong")

        guard let shortestPath2 = BFSPG(graph: graph, start: "A", end: "B") else {
            XCTFail("Error finding shortest path")
            return
        }
        XCTAssertEqual(Array(shortestPath2), ["A", "C", "B"], "The  shortest path for \(graphFileName) is wrong")

        guard let shortestPath3 = BFSPG(graph: graph, start: "A", end: "E") else {
            XCTFail("Error finding shortest path")
            return
        }
        XCTAssertEqual(Array(shortestPath3), [], "The  shortest path for \(graphFileName) is wrong")
		
		XCTAssertNil(BFSPG(graph: graph, start: "A", end: "F"), "Trying to generate shortest path on existent nodes should fail")
    }

}
