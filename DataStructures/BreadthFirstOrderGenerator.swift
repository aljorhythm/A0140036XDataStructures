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

	/**
		Represents a node and the path it takes to get to it
	*/
	struct PathTo {
		let key: Key
		let path: Path
	}

	private var arranged: [Key]
	private var iteratorIndex = -1

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

	/**
		Shortest path using bfs
	*/
	private struct BfsShortestPath {

		private var arranged = [Key]()
		private var visitingQueue = Queue<PathTo>()
		private(set) var shortestPath: [Key]?
		private let end: Key
		private let graph: Graph

		/**
			Finds a shortest path from one node to another in a graph
		*/
		init(graph: Graph, start: Key, end: Key) {
			self.end = end
			self.graph = graph
			bfsShortestPath(start: start)
		}

		/**
			Algorithm
		**/
		private mutating func bfsShortestPath(start: Key) {
			bfsShortestPath(pathTo: PathTo(key: start, path: [start]))
		}

		private mutating func bfsShortestPath(pathTo: PathTo) {
			let hasVisited = arranged.contains(pathTo.key)

			var currentShortestPathLength: Int
			if let length = shortestPath?.count {
				currentShortestPathLength = length
			} else {
				currentShortestPathLength = Int.max
			}

			if end == pathTo.key && pathTo.path.count < currentShortestPathLength {
				shortestPath = pathTo.path.count < currentShortestPathLength ? pathTo.path : shortestPath
				return
			}

			if !hasVisited {
				arranged.append(pathTo.key)
			}

			graph[pathTo.key]?.forEach {
				if !arranged.contains($0) {
					visitingQueue.enqueue(PathTo(key: $0, path: pathTo.path + [$0]))
				}
			}

			while let nextRoot = visitingQueue.dequeue() {
				bfsShortestPath(pathTo: nextRoot)
			}
		}
	}

    /// Constructs a `BreadthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
    public init?(graph: Graph, start: Key) {
		arranged = BreadthFirstOrderGenerator.bfs(graph, subgraphRoot: start)
    }

	/// Constructs a `BreadthFirstOrderGenerator` with the given graph, start
	/// node and end node.
	/// - Parameters:
	///   - graph: A dictionary of node to adjacency list pairs.
	///   - start: The start node.
	///	  - end: The end node
	public init?(graph: Graph, start: Key, end: Key) {
		let bfs = BfsShortestPath(graph: graph, start: start, end: end)
		arranged = bfs.shortestPath ?? []
	}

    public func makeIterator() -> BreadthFirstOrderGenerator<Key, Value> {
        return self
    }

	/**
	- Returns: nil if end of sequence
	*/
    public mutating func next() -> Key? {
		iteratorIndex += 1
		return arranged.count > iteratorIndex ? arranged[iteratorIndex] : nil
    }
}
