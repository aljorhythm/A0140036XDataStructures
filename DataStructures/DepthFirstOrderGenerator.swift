// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in depth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2018
 */
struct DepthFirstOrderGenerator<Key: Hashable, Value: Collection>: IteratorProtocol,
    Sequence where Value.Iterator.Element == Key {

	private var arranged: [Key]
	private var iteratorIndex = -1

	/**
	Depth first search algorithm
	
	- Parameter graph: Adjacency list representation of entire graph
	- Parameter subgraphRoot: subgraph root that is traversed
	- Parameter arranged: Array of graph nodes arranged in depth first order.
	Nodes will be added in order by the recursive calls.
	*/
	static func dfs(_ graph: [Key: Value], subgraphRoot: Key, arranged: inout [Key]) {
		if !arranged.contains(subgraphRoot) {
            // [-1] styling: prefer guard statement.

			arranged.append(subgraphRoot)

			if let children = graph[subgraphRoot] {
				children.forEach { dfs( graph, subgraphRoot: $0, arranged: &arranged) }
                // [-1] Styling:       ^ unnecessary space in method call.
			}
            // [-1] Styling: Prefer guard statement.
		}
        // TA: Having guard statements will avoid unnecessary nested calls.
	}

    /// Constructs a `DepthFirstOrderGenerator` with the given graph and start
    /// node.
    /// - Parameters:
    ///   - graph: A dictionary of node to adjacency list pairs.
    ///   - start: The start node.
	init?(graph: [Key: Value], start: Key) {
		arranged = []
        // [-0] style: should instantiate at the properties instead of init.
        // Will become problematic when we have multiple constructors.
		DepthFirstOrderGenerator.dfs(graph, subgraphRoot: start, arranged: &arranged)
	}

	func makeIterator() -> DepthFirstOrderGenerator<Key, Value> {
		return self
	}

	/**
	- Returns: nil if end of sequence
	*/
	mutating func next() -> Key? {
		iteratorIndex += 1
		return iteratorIndex < arranged.count ? arranged[iteratorIndex] : nil
	}
}
