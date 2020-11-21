import UIKit

// References:
// https://www.raywenderlich.com/books/design-patterns-by-tutorials/v3.0/chapters/7-memento-pattern/
// https://refactoring.guru/design-patterns/memento/swift/example

///////////////////////////////
////////  Memento /////////////
///////////////////////////////

// Allows an object to be saved and restored

// Three elements: Originator, Memento, Care taker

// Originator: object to be saved or restored
// Memento: represents the stored state
// Care taker: requests save from the originator and receives a memento in response. The caretaker is responsible for persisting the memento and, later on, providing the memento back to the originator to restore the originator’s state.


// Use case: Undo functionalities
// Array of mementos can be used for stacks with previous states


/// The Originator holds some important state that may change over time. It also
/// defines a method for saving the state inside a memento and another method
/// for restoring the state from it.
class Originator {

    /// For the sake of simplicity, the originator's state is stored inside a
    /// single variable.
    private var state: String

    init(state: String) {
        self.state = state
        print("Originator: My initial state is: \(state)")
    }

    /// The Originator's business logic may affect its internal state.
    /// Therefore, the client should backup the state before launching methods
    /// of the business logic via the save() method.
    func doSomething() {
        print("Originator: I'm doing something important.")
        state = generateRandomString()
        print("Originator: and my state has changed to: \(state)")
    }

    private func generateRandomString() -> String {
        return String(UUID().uuidString.suffix(4))
    }

    /// Saves the current state inside a memento.
    func save() -> Memento {
        return ConcreteMemento(state: state)
    }

    /// Restores the Originator's state from a memento object.
    func restore(memento: Memento) {
        guard let memento = memento as? ConcreteMemento else { return }
        self.state = memento.state
        print("Originator: My state has changed to: \(state)")
    }
}

/// The Memento interface provides a way to retrieve the memento's metadata,
/// such as creation date or name. However, it doesn't expose the Originator's
/// state.
protocol Memento {
    var name: String { get }
    var date: Date { get }
}

/// The Concrete Memento contains the infrastructure for storing the
/// Originator's state.
class ConcreteMemento: Memento {

    /// The Originator uses this method when restoring its state.
    private(set) var state: String
    private(set) var date: Date

    init(state: String) {
        self.state = state
        self.date = Date()
    }

    /// The rest of the methods are used by the Caretaker to display metadata.
    var name: String { return state + " " + date.description.suffix(14).prefix(8) }
}

/// The Caretaker doesn't depend on the Concrete Memento class. Therefore, it
/// doesn't have access to the originator's state, stored inside the memento. It
/// works with all mementos via the base Memento interface.
class Caretaker {

    private lazy var mementos = [Memento]()
    private var originator: Originator

    init(originator: Originator) {
        self.originator = originator
    }

    func backup() {
        print("\nCaretaker: Saving Originator's state...\n")
        mementos.append(originator.save())
    }

    func undo() {

        guard !mementos.isEmpty else { return }
        let removedMemento = mementos.removeLast()

        print("Caretaker: Restoring state to: " + removedMemento.name)
        originator.restore(memento: removedMemento)
    }

    func showHistory() {
        print("Caretaker: Here's the list of mementos:\n")
        mementos.forEach({ print($0.name) })
    }
}

let originator = Originator(state: "Super-duper-super-puper-super.")
let caretaker = Caretaker(originator: originator)

caretaker.backup()
originator.doSomething()

caretaker.backup()
originator.doSomething()

caretaker.backup()
originator.doSomething()

print("\n")
caretaker.showHistory()

print("\nClient: Now, let's rollback!\n\n")
caretaker.undo()

print("\nClient: Once more!\n\n")
caretaker.undo()


