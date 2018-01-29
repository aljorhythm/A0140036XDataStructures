// Copyright (c) 2018 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class BreadthFirstOrderGeneratorTests: XCTestCase {

	func testShortestPath() {
		let graphFileName = "graph_simple_bfs_shortest"
		guard let graph = getGraph(graphFileName) else {
			XCTFail("Path not found")
			return
		}
		guard let shortestPath = BreadthFirstOrderGenerator(graph: graph, start: "A", end: "D") else {
			XCTFail("Error finding shortest path")
			return
		}
		XCTAssertEqual(Array(shortestPath), ["A", "C", "D"], "The  shortest path for \(graphFileName) is wrong")

		guard let shortestPath2 = BreadthFirstOrderGenerator(graph: graph, start: "A", end: "B") else {
			XCTFail("Error finding shortest path")
			return
		}
		XCTAssertEqual(Array(shortestPath2), ["A", "C", "B"], "The  shortest path for \(graphFileName) is wrong")

		guard let shortestPath3 = BreadthFirstOrderGenerator(graph: graph, start: "A", end: "E") else {
			XCTFail("Error finding shortest path")
			return
		}
		XCTAssertEqual(Array(shortestPath3), [], "The  shortest path for \(graphFileName) is wrong")
	}

    func testCyclicGraph() {
        let graphFileName = "graph_cycle"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "A"),
            ["A", "B", "C", "D"],
            "The BFS for \(graphFileName) is wrong!")
    }

    func testLinkedListGraph() {
        let graphFileName = "graph_linkedlist"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "A"),
            ["A", "B", "C", "D", "E"],
            "The BFS for \(graphFileName) is wrong!")
    }

    func testExampleGraph() {
        let graphFileName = "graph_example"
        XCTAssertEqual(getResultantNodesForGraph(graphFileName, startNode: "A"),
            ["A", "B", "C", "E", "D", "F", "G"],
            "The BFS for \(graphFileName) is wrong!")
    }

	private func getGraph(_ fileName: String) -> [String: [String]]? {
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

    private func getResultantNodesForGraph(_ fileName: String, startNode: String) -> [String] {
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
