// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in breadth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2018
 */

public struct BreadthFirstOrderGenerator<Key: Hashable, Value: Collection>: IteratorProtocol,
Sequence where Value.Iterator.Element == Key {

    public typealias Graph = [Key: Value]
    public typealias Path = [Key]

    private var arranged: [Key]?
    private var iteratorIndex = -1
    private var start: Key
    private var graph: Graph

    /**
     Breadth First Order algorithm
     */
    public static func bfs(_ graph: Graph, subgraphRoot: Key) -> [Key] {
        var visitingQueue = Queue<Key>()
        var arranged = [Key]()
        bfs(graph, subgraphRoot: subgraphRoot, arranged: &arranged, visitingQueue: &visitingQueue)
        return arranged
    }

    private static func bfs(_ graph: Graph, subgraphRoot: Key, arranged: inout [Key], visitingQueue: inout Queue<Key>) {
        if !arranged.contains(subgraphRoot) {
            arranged.append(subgraphRoot)
        }

        if let children = graph[subgraphRoot] {
            for childNode in children {
                if !arranged.contains(childNode) {
                    visitingQueue.enqueue(childNode)
                }
            }
        }

        while let nextRoot = visitingQueue.dequeue() {
            bfs(graph, subgraphRoot: nextRoot, arranged: &arranged, visitingQueue: &visitingQueue)
        }
    }

    /// Constructs a `BreadthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    public init?(graph: Graph, start: Key) {
        self.graph = graph
        self.start = start
    }
	
	public func makeIterator() -> BreadthFirstOrderGenerator<Key, Value> {
		return self
	}

    /**
     - Returns: nil if end of sequence
     */
    public mutating func next() -> Key? {
		if self.arranged == nil {
			self.arranged = BreadthFirstOrderGenerator.bfs(graph, subgraphRoot: start)
		}
        guard let arranged = self.arranged else {
            assertionFailure("Arranged nodes do not exist")
            return nil
        }
        iteratorIndex += 1
        return arranged.count > iteratorIndex ? arranged[iteratorIndex] : nil
    }
}
