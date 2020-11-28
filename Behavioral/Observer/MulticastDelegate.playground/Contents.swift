import UIKit

// Reference: 

////////////////////////////////////////////////////
/// Multicast Delegate / Delegates composition /////
////////////////////////////////////////////////////

protocol MyClassDelegate: class {
    func doFoo()
}

class MyClass {
    weak var delegate: MyClassDelegate?

    func foo() {
        delegate?.doFoo()
    }
}

class Logger {
    init() {}
}

extension Logger: MyClassDelegate {
    func doFoo() {
        print("Foo called")
    }
}

let logger = Logger()

let myClass = MyClass()
myClass.delegate = logger

print("Standard Delegate")
myClass.foo()


class MulticastDelegate<T> {

    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    func add(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }

    func remove(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() {
            if delegate === delegateToRemove as AnyObject {
                delegates.remove(delegate)
            }
        }
    }

    func invoke(_ invocation: (T) -> Void) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
}

class MyClassMulticastDelegate: MyClassDelegate {

    private let multicast = MulticastDelegate<MyClassDelegate>()

    init(_ delegates: [MyClassDelegate]) {
        delegates.forEach(multicast.add)
    }

    func doFoo() {
        multicast.invoke { $0.doFoo() }
    }
}

class AnalyticsEngine {}

extension AnalyticsEngine: MyClassDelegate {
    func doFoo() {
        print("Track foo event")
    }
}

let loggerV2 = Logger()
let analyticsEngine = AnalyticsEngine()
let delegate = MyClassMulticastDelegate([logger, analyticsEngine])

let myClassV2 = MyClass()
myClass.delegate = delegate

print("Multicast Delegate")
myClass.foo()
