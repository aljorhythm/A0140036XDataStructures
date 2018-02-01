//
//  DepthFirstShortestPathGenerator.swift
//  DataStructures
//
//  Created by Joel Lim on 31/1/18.
//  Copyright © 2018 NUS CS3217. All rights reserved.
//

import Foundation

/**
 Shortest path using bfs
 */
public struct BreadthFirstShortestPathGenerator <Key: Hashable, Value: Collection>: IteratorProtocol,
Sequence where Value.Iterator.Element == Key {

    public typealias Graph = [Key: Value]
    public typealias Path = [Key]

    /**
     Represents a node and the path it takes to get to it
     */
    struct PathTo {
        let key: Key
        let path: Path
		init(_ key: Key, isThis path: Path) {
			self.key = key
			self.path = path
		}
    }

    private var arranged = [Key]()
    private var visitingQueue = Queue<PathTo>()
    private(set) var shortestPath: [Key]?
    private let end: Key
    private let graph: Graph
    private let start: Key
    private var iteratorIndex = -1

    /**
		Finds a shortest path from one node to another in a graph.
		Fails if either start or end is not in graph
     */
    init?(graph: Graph, start: Key, end: Key) {
        self.start = start
        self.end = end
        self.graph = graph
		
		guard graph[self.start] != nil, graph[self.end] != nil else {
			return nil
		}
    }

    /** Algorithm **/
	
	/**
	- PostCondition: shortest path is computed, even for unconnected nodes
	*/
    private mutating func computeShortestPath() {
		bfsShortestPath(pathTo: PathTo(start, isThis: [start]))
		shortestPath = shortestPath ?? []
    }

    private mutating func bfsShortestPath(pathTo: PathTo) {
        let hasVisited = arranged.contains(pathTo.key)
		print("arranged \(arranged)")

        var currentShortestPathLength: Int
		
        if let shortestPath = self.shortestPath {
            currentShortestPathLength = shortestPath.count
        } else {
            currentShortestPathLength = Int.max
        }

		print("\(end) \(pathTo.key) \(pathTo) \(end == pathTo.key) current shortest path length \(pathTo.path.count) < \(currentShortestPathLength)")
        if end == pathTo.key {
            self.shortestPath = pathTo.path.count < currentShortestPathLength ? pathTo.path : shortestPath
			print("shortest \(pathTo.path.count < currentShortestPathLength) \(shortestPath)")
            return
        }

        if !hasVisited {
            arranged.append(pathTo.key)
        }

        graph[pathTo.key]?.forEach {
            if !arranged.contains($0) {
                visitingQueue.enqueue(PathTo($0, isThis: pathTo.path + [$0]))
            }
        }

        while let nextRoot = visitingQueue.dequeue() {
            bfsShortestPath(pathTo: nextRoot)
        }
    }

    public func makeIterator() -> BreadthFirstShortestPathGenerator<Key, Value> {
        return self
    }

    /**
     - Returns: nil if end of sequence
     */
    public mutating func next() -> Key? {
		if self.shortestPath == nil {
			computeShortestPath()
		}
		guard let shortestPath = self.shortestPath else {
			assertionFailure("shortestPath cannot be nil")
			return nil
		}
		print(shortestPath)
        iteratorIndex += 1
		guard iteratorIndex < shortestPath.count else {
			return nil
		}
		return shortestPath[iteratorIndex]
    }
}
