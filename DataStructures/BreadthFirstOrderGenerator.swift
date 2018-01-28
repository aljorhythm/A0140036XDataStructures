// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generator that returns the nodes in the graph in breadth-first search order,
 starting at the given node.

 - Authors: CS3217
 - Date: 2018
 */
struct BreadthFirstOrderGenerator<Key: Hashable, Value: Collection>: IteratorProtocol,
    Sequence where Value.Iterator.Element == Key {

	private var arranged : [Key]
	private var iteratorIndex = -1

	/**
		Breadth First Order algorithm
	*/
	static func bfs(_ graph: [Key:Value], subgraphRoot: Key) -> [Key]{
		var visitingQueue = Queue<Key>()
		var arranged = [Key]()
		bfs(graph, subgraphRoot: subgraphRoot, arranged: &arranged, visitingQueue: &visitingQueue)
		return arranged
	}
	
	private static func bfs(_ graph: [Key: Value], subgraphRoot: Key, arranged: inout [Key], visitingQueue: inout Queue<Key>) {
		if !arranged.contains(subgraphRoot) {
			arranged.append(subgraphRoot)
		}
		
		if let children = graph[subgraphRoot] {
			for childNode in children  {
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
    init?(graph: [Key: Value], start: Key) {
		arranged = BreadthFirstOrderGenerator.bfs(graph, subgraphRoot: start)
    }

    func makeIterator() -> BreadthFirstOrderGenerator<Key, Value> {
        return self
    }

	/**
	- Returns: nil if end of sequence
	*/
    mutating func next() -> Key? {
		iteratorIndex += 1
		return arranged.count > iteratorIndex ? arranged[iteratorIndex] : nil
    }
}
