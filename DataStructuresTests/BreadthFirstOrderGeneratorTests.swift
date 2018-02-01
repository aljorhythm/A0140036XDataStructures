// Copyright (c) 2018 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class BreadthFirstOrderGeneratorTests: XCTestCase {

    func testCyclicGraph() {
        let graphFileName = "graph_cycle"
        XCTAssertEqual(BreadthFirstOrderGeneratorTests.getResultantNodesForGraph(graphFileName, startNode: "A"),
                       ["A", "B", "C", "D"],
                       "The BFS for \(graphFileName) is wrong!")
    }

    func testLinkedListGraph() {
        let graphFileName = "graph_linkedlist"
        XCTAssertEqual(BreadthFirstOrderGeneratorTests.getResultantNodesForGraph(graphFileName, startNode: "A"),
                       ["A", "B", "C", "D", "E"],
                       "The BFS for \(graphFileName) is wrong!")
    }

    func testExampleGraph() {
        let graphFileName = "graph_example"
        XCTAssertEqual(BreadthFirstOrderGeneratorTests.getResultantNodesForGraph(graphFileName, startNode: "A"),
                       ["A", "B", "C", "E", "D", "F", "G"],
                       "The BFS for \(graphFileName) is wrong!")
    }

    static func getGraph(_ fileName: String) -> [String: [String]]? {
        // You do not need to modify this function.
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            XCTFail("Path should not be nil.")
            return nil
        }
        guard let dictionary = NSDictionary(contentsOfFile: path), let graph = dictionary as? [String: [String]] else {
            XCTFail("Graph should not be nil.")
            return nil
        }
        return graph
    }

    static func getResultantNodesForGraph(_ fileName: String, startNode: String) -> [String] {
        guard let graph = getGraph(fileName) else {
            XCTFail("Graph should not be nil.")
            return []
        }

        guard let bfsGenerator = BreadthFirstOrderGenerator(graph: graph, start: startNode) else {
            return []
        }

        var nodes: [String] = []
        for node in bfsGenerator {
            nodes.append(node as String)
        }
        return nodes
    }
}
