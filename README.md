CS3217 Problem Set 1
==

**Name:** Joel Lim Jing

**Matric No:** A0140036X

**Tutor:** Wang Xien Dong

## Instructions for Students

1. Clone this repository to begin working.
2. Do not modify the `AppDelegate.swift`, `LaunchScreen.xib`, `Main.storyboard`, `Images.xcassets` files (you do not have to).
3. Write your answers to non-coding questions in this file (`README.md`).

## Tips

1. CS3217's Gitbook is at https://www.gitbook.com/book/cs3217/problem-sets/details. Do visit the Gitbook often, as it contains all things relevant to CS3217. You can also ask questions related to CS3217 there.
2. Take a look at `.gitignore`. It contains rules that ignores the changes in certain files when committing an Xcode project to revision control. (This is taken from https://github.com/github/gitignore/blob/master/Swift.gitignore).
3. A Swiftlint configuration file is provided for you. It is recommended for you to use Swiftlint and follow this configuration. Keep in mind that, ultimately, this tool is only a guideline; some exceptions may be made as long as code quality is not compromised.
4. Do not burn out. Have fun!

## Problem 1: Swift Collections

### Readings

- [Hashable - Swift Standard Library | Apple Developer Documentation](https://developer.apple.com/documentation/swift/hashable)
- [Dictionary - Swift Standard Library _ Apple Developer Documentation](https://developer.apple.com/documentation/swift/dictionary)

### Answers

If keys do not conform to Hashable protocol there is no standard to tell if two keys are equal. Keys can be of types that are not primitives like Integer or String, ie. they can be points on a plane, an object, etc. The implementation of Dictionary identifies keys by their .hashValue property.

## Problem 3: Graph Traversal

## Problem 3.3

### Readings

- [The Swift Programming Language (Swift 4.0.3): Error Handling](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html)
- [error handling - Should a retrieval method return 'null' or throw an exception when it can't produce the return value? - Stack Overflow](https://stackoverflow.com/questions/175532/should-a-retrieval-method-return-null-or-throw-an-exception-when-it-cant-prod)

### Answer

We should throw an exception if it is truly an error (nil is unexpected). It is expected that there is an end to a queue or stack. 

In Swift, using nil together with optional chainging makes it easier to read and write certain lines.

```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```

But suppose it should always be possible to fetch data from disk then throwing an exception would be appropriate.