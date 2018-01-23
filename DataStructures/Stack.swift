// Copyright (c) 2018 NUS CS3217. All rights reserved.

/**
 A generic `Stack` class whose elements are last-in, first-out.

 - Authors: CS3217
 - Date: 2018
 */
struct Stack<T> {

	// element 0 is top of the stack, element length - 1 is bottom of stack
	var array: [T] = []
    // [-0] Style - for not keeping array private.

    /// Adds an element to the top of the stack.
    /// - Parameter item: The element to be added to the stack
    mutating func push(_ item: T) {
		array.insert(item, at: 0)
    }

    /// Removes the element at the top of the stack and return it.
    /// - Returns: element at the top of the stack, nil if stack is empty
    mutating func pop() -> T? {
		return isEmpty ? nil : array.removeFirst()
    }

    /// Returns, but does not remove, the element at the top of the stack.
    /// - Returns: element at the top of the stack
    func peek() -> T? {
        return array.first
    }

    /// The number of elements currently in the stack.
    var count: Int {
        return array.count
    }

    /// Whether the stack is empty.
    var isEmpty: Bool {
		return array.isEmpty
    }

    /// Removes all elements in the stack.
    mutating func removeAll() {
		array.removeAll()
    }

    /// Returns an array of the elements in their respective pop order, i.e.
    /// first element in the array is the first element to be popped.
    /// - Returns: array of elements in their respective pop order
    func toArray() -> [T] {
        return array
    }
}
