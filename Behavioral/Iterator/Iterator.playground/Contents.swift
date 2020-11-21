import UIKit

////////////////////////
///// ITERATOR /////////
////////////////////////

// Usually embedded in the programming language
// Enables us to iterate over a collection of elements
// Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation

protocol Iterator {
    func next<T>() -> T?
}

protocol Iterable {
    func makeIterator() -> Iterator
}

class ArrayIterator<T>: Iterator {

    private let values: [T]
    private var index: Int?

    init(_ values: [T]) {
        self.values = values
    }

    private func nextIndex(for index: Int?) -> Int? {
        if
            let index = index,
            index < self.values.count - 1 {
                return index + 1
        }
        if
            index == nil,
            !self.values.isEmpty {
                return 0
        }
        return nil
    }

    func next<T>() -> T? {
        if let index = self.nextIndex(for: self.index) {
            self.index = index
            return self.values[index] as? T
        }
        return nil
    }
}

class DataArray: Iterable {

    private var dataSource: [String]

    init() {
        self.dataSource = ["🐶", "🐔", "🐵", "🦁", "🐯", "🐭", "🐱", "🐮", "🐷"]
    }

    func makeIterator() -> Iterator {
        return ArrayIterator<String>(self.dataSource)
    }
}

// Usage

let data = DataArray()
let iterator = data.makeIterator()

while let next: String = iterator.next() {
    print(next)
}



