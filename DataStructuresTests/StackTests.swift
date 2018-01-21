// Copyright (c) 2018 NUS CS3217. All rights reserved.

import XCTest
@testable import DataStructures

class StackTests: XCTestCase {

    func testPush() {
        var stack = Stack<Int>()
        stack.push(1)

        XCTAssertEqual(stack.toArray(), [1], "The item is not pushed correctly!")
    }

    func testPop() {
		var stack = Stack<String>()
		
		var next = stack.pop()
		XCTAssertEqual(next, nil, "There is no item to pop!")
		
		stack.push("1")
		stack.push("2")
		stack.push("3")
		
		next = stack.pop()
		XCTAssertEqual(next, "3", "The item is not poped correctly!")
		
		XCTAssertEqual(stack.toArray(), ["2", "1"], "The item is not poped correctly!")
    }

    func testPeek() {
		var stack = Stack<String>()
		stack.push("1")
		stack.push("2")
		stack.push("3")
		
		let next = stack.peek()
		XCTAssertEqual(next, "3", "The item is not peeked correctly!")
		
		XCTAssertEqual(stack.toArray(), ["3", "2", "1"], "The item should not be removed when peeked!")
    }

    func testCount() {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        XCTAssertEqual(stack.count, 3, "The stack's length is not correct!");
    }

    func testIsEmpty() {
		var stack = Stack<String>()
		
		XCTAssertEqual(stack.isEmpty, true, "TThe stack should be empty")
		
		stack.push("a")
		XCTAssertEqual(stack.isEmpty, false, "The stack should not be empty!")
    }

    func testRemoveAll() {
		var stack = Stack<String>()
		stack.push("1")
		stack.push("2")
		stack.push("3")
		
		stack.removeAll()
		XCTAssertEqual(stack.isEmpty, true, "The stack should be empty after removing all elements!");
    }

    func testToArray() {
		var stack = Stack<String>()
		let testArray = "abcdefgh".map { String ($0)}
		testArray.forEach {stack.push($0)}
		XCTAssertEqual(stack.toArray(), testArray.reversed(), "The queue is not converted to array correctly!");
    }
}
