// Copyright (c) 2018 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class Dictionary_TraversableTests: XCTestCase {

    func testExampleGraph() {
        let graphFileName = "graph_example"
        guard let graph = getGraph(graphFileName) as? [String: [String]] else {
            XCTFail("Graph should be valid!")
            return
        }
        let nodeA = "A"

        guard var bfsGenerator = graph.breadthFirstOrderGeneratorFromNode(nodeA) else {
            XCTFail("Initialisation of bfs generator should succeed.")
            return
        }

        XCTAssertEqual(bfsGenerator.next(), "A", "First node of bfs for \(graphFileName) from \(nodeA) should be 'A'!")
        XCTAssertEqual(bfsGenerator.next(), "B", "Second node of bfs for \(graphFileName) from \(nodeA) should be 'B'!")
        XCTAssertEqual(bfsGenerator.next(), "C", "Third node of bfs for \(graphFileName) from \(nodeA) should be 'C'!")
        XCTAssertEqual(bfsGenerator.next(), "E", "Fourth node of bfs for \(graphFileName) from \(nodeA) should be 'E'!")
        XCTAssertEqual(bfsGenerator.next(), "D", "Fifth node of bfs for \(graphFileName) from \(nodeA) should be 'D'!")
        XCTAssertEqual(bfsGenerator.next(), "F", "Sixth node of bfs for \(graphFileName) from \(nodeA) should be 'F'!")
        XCTAssertEqual(bfsGenerator.next(), "G",
                       "Seventh node of bfs for \(graphFileName) from \(nodeA) should be 'G'!")

        let bfsNodes = graph.nodesSequenceInBreadthFirstOrderFromNode(nodeA)
        XCTAssertEqual(bfsNodes, ["A", "B", "C", "E", "D", "F", "G"],
                       "The bfs for \(graphFileName) from \(nodeA) is wrong!")

        guard var dfsGenerator = graph.depthFirstOrderGeneratorFromNode(nodeA) else {
            XCTFail("Initialisation of dfs generator should succeed.")
            return
        }

        XCTAssertEqual(dfsGenerator.next(), "A", "First node of dfs for \(graphFileName) from \(nodeA) should be 'A'!")
        XCTAssertEqual(dfsGenerator.next(), "B", "Second node of dfs for \(graphFileName) from \(nodeA) should be 'B'!")
        XCTAssertEqual(dfsGenerator.next(), "D", "Third node of dfs for \(graphFileName) from \(nodeA) should be 'D'!")
        XCTAssertEqual(dfsGenerator.next(), "F", "Fourth node of dfs for \(graphFileName) from \(nodeA) should be 'F'!")
        XCTAssertEqual(dfsGenerator.next(), "E", "Fifth node of dfs for \(graphFileName) from \(nodeA) should be 'E'!")
        XCTAssertEqual(dfsGenerator.next(), "C", "Sixth node of dfs for \(graphFileName) from \(nodeA) should be 'C'!")
        XCTAssertEqual(dfsGenerator.next(), "G",
                       "Seventh node of dfs for \(graphFileName) from \(nodeA) should be 'G'!")

        let dfsNodes = graph.nodesSequenceInDepthFirstOrderFromNode(nodeA)
        XCTAssertEqual(dfsNodes, ["A", "B", "D", "F", "E", "C", "G"],
                       "The dfs for \(graphFileName) from \(nodeA) is wrong!")
    }

    private func getGraph(_ fileName: String) -> NSDictionary {
        // You do not need to modify this function.
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            XCTFail("Path should not be nil.")
            return NSDictionary()
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) else {
            XCTFail("Dictionary should not be nil.")
            return NSDictionary()
        }
        return dictionary
    }
}
