// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generic `Queue` class whose elements are first-in, first-out.

 - Authors: CS3217
 - Date: 2018
 */
public struct Queue<T> {

	private var array: [T] = []

    /// Adds an element to the tail of the queue.
    /// - Parameter item: The element to be added to the queue
    public mutating func enqueue(_ item: T) {
		array.append(item)
    }

    /// Removes an element from the head of the queue and return it.
    /// - Returns: item at the head of the queue, nil if queue is empty
    public mutating func dequeue() -> T? {
		return isEmpty ? nil : array.removeFirst()
    }

    /// Returns, but does not remove, the element at the head of the queue.
    /// - Returns: item at the head of the queue
    public func peek() -> T? {
         return array.first
    }

    /// The number of elements currently in the queue.
    public var count: Int {
         return array.count
    }

    /// Whether the queue is empty.
    public var isEmpty: Bool {
        return array.isEmpty
    }

    /// Removes all elements in the queue.
    public mutating func removeAll() {
		array.removeAll()
    }

    /// Returns an array of the elements in their respective dequeue order, i.e.
    /// first element in the array is the first element to be dequeued.
    /// - Returns: array of elements in their respective dequeue order
    public func toArray() -> [T] {
        return array
    }
}
