// Copyright (c) 2018 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class QueueTests: XCTestCase {

    func testEnqueue() {
        var queue = Queue<String>()
        queue.enqueue("1")

        XCTAssertEqual(queue.toArray(), ["1"], "The item is not enqueued correctly!")
    }

    func testDequeue() {
		var queue = Queue<String>()

		var next = queue.dequeue()
		XCTAssertEqual(next, nil, "The queue should be empty!")

		queue.enqueue("1")
		queue.enqueue("2")
		queue.enqueue("3")

		next = queue.dequeue()
		XCTAssertEqual(next, "1", "The item is not dequeued correctly!")

		XCTAssertEqual(queue.toArray(), ["2", "3"], "The item is not dequeued correctly!")
    }

    func testPeek() {
		var queue = Queue<String>()
		queue.enqueue("1")
		queue.enqueue("2")
		queue.enqueue("3")

		let next = queue.peek()
		XCTAssertEqual(next, "1", "The item is not peeked correctly!")

		XCTAssertEqual(queue.toArray(), ["1", "2", "3"], "The item should not be removed when peeked!")
    }

    func testCount() {
        var queue = Queue<String>()

		XCTAssertEqual(queue.count, 0, "The queue's length is not correct!")

        queue.enqueue("1")
        queue.enqueue("2")
        queue.enqueue("3")
        XCTAssertEqual(queue.count, 3, "The queue's length is not correct!")
    }

    func testIsEmpty() {
		var queue = Queue<String>()

		XCTAssertEqual(queue.isEmpty, true, "TThe queue should be empty")

		queue.enqueue("a")
		XCTAssertEqual(queue.isEmpty, false, "The queue should not be empty!")
    }

    func testRemoveAll() {
		var queue = Queue<String>()
		queue.enqueue("1")
		queue.enqueue("2")
		queue.enqueue("3")

		queue.removeAll()
		XCTAssertEqual(queue.isEmpty, true, "The queue should be empty after removing all elements!")
    }

    func testToArray() {
		var queue = Queue<String>()
		let testArray = "abcdefgh".map { String ($0) }
		testArray.forEach { queue.enqueue($0) }
		XCTAssertEqual(queue.toArray(), testArray, "The queue is not converted to array correctly!")
    }
}
