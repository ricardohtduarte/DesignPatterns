import UIKit

// Reference: https://khawerkhaliq.com/blog/swift-design-patterns-state-pattern/

////////////////////////
/////// State //////////
////////////////////////

// The State pattern enables an entity, which can change its behaviour based on its internal state, to use a set of types conforming to a common interface to represent these states. This allows behaviour related to states, and transitions between states, to be modeled in a flexible and extensible manner. The State pattern provides an effective way to implement finite state machines.

// Components

// Context: obbject that has the current state and whose behaviour change (ATMMachine)
// State protocol: defines required methods and properties (ATMState)
// Concrete states: conform to the state protocol, or if a base class is used instead, they subclass the base. The context holds onto its current state, but it doesn't know its concrete state type. Instead, the context changes behavior using polymorphism: concrete states define how the context should act. If you ever need a new behavior, you define a new concrete state. (HasCard, NoCard, HasCorrectPin, RequestCash)

// ATM Machine example

protocol ATMState {
    func insertCard()
    func ejectCard()
    func insertPin(enteredPin: Int)
    func requestCash(amount: Int)
}

class ATMMachine {
    var hasCard: ATMState?
    var noCard: ATMState?
    var hasCorrectPin: ATMState?
    var outOfMoney: ATMState?
    
    var cashInMachine = 2000
    var correctPinEntered = false
    var atmState: ATMState?
    
    init() {
        hasCard = HasCard(atmMachine: self)
        noCard = NoCard(atmMachine: self)
        hasCorrectPin = HasCorrectPin(atmMachine: self)
        outOfMoney = OutOfMoney(atmMachine: self)
        
        guard cashInMachine > 0 else {
            atmState = outOfMoney
            return
        }
        
        atmState = noCard
    }

    func setATMState(newATMState: ATMState?) {
        atmState = newATMState
    }

    func setCashInMachine(newAmount: Int) {
        cashInMachine = newAmount
    }

    func insertCard() {
        atmState?.insertCard()
    }

    func ejectCard() {
        atmState?.ejectCard()
    }

    func requestCash(withdrawAmount: Int) {
        atmState?.requestCash(amount: withdrawAmount)
    }

    func insertPin(enteredPin: Int) {
        atmState?.insertPin(enteredPin: enteredPin)
    }
}

//////////////////////////////
///// Concrete States ////////
//////////////////////////////

final class HasCard: ATMState {
    private let atmMachine: ATMMachine

    init(atmMachine: ATMMachine) {
        self.atmMachine = atmMachine
    }
    
    func insertCard() {
        print("You can't enter more than one card")
    }
    
    func ejectCard() {
        print("Card ejected")
        atmMachine.setATMState(newATMState: atmMachine.noCard)
    }
    
    func insertPin(enteredPin: Int) {
        if enteredPin == 1234 {
            print("Correct pin")
            atmMachine.correctPinEntered = true
            atmMachine.setATMState(newATMState: atmMachine.hasCorrectPin)
        } else {
            print("Wrong pin")
            atmMachine.correctPinEntered = false
            print("Card ejected")
            atmMachine.setATMState(newATMState: atmMachine.noCard)
        }
    }
    
    func requestCash(amount: Int) {
        print("Enter pin first")
    }
}


final class NoCard: ATMState {
    private let atmMachine: ATMMachine

    init(atmMachine: ATMMachine) {
        self.atmMachine = atmMachine
    }
    
    func insertCard() {
        atmMachine.setATMState(newATMState: atmMachine.hasCard)
        print("Card inserted")
    }
    
    func ejectCard() {
        print("Card ejected")
        atmMachine.setATMState(newATMState: atmMachine.noCard)
    }
    
    func insertPin(enteredPin: Int) {
        print("Insert card first")
    }
    
    func requestCash(amount: Int) {
        print("Insert card first")
    }
}

final class HasCorrectPin: ATMState {
    private let atmMachine: ATMMachine

    init(atmMachine: ATMMachine) {
        self.atmMachine = atmMachine
    }
    
    func insertCard() {
        print("You can't enter more than one card")
    }
    
    func ejectCard() {
        print("Card ejected")
        atmMachine.setATMState(newATMState: atmMachine.noCard)
    }
    
    func insertPin(enteredPin: Int) {
        print("Pin already inserted")
    }
    
    func requestCash(amount: Int) {
        atmMachine.requestCash(withdrawAmount: 10)
        print("Here your \(amount) bucks")
    }
}

final class OutOfMoney: ATMState {
    private let atmMachine: ATMMachine

    init(atmMachine: ATMMachine) {
        self.atmMachine = atmMachine
    }
    
    func insertCard() {
        print("Machine is out of money")
    }
    
    func ejectCard() {
        print("Machine is out of money")
    }
    
    func insertPin(enteredPin: Int) {
        print("Machine is out of money")
    }
    
    func requestCash(amount: Int) {
        print("Machine is out of money")
    }
}


//////////////////////////////
///////// USAGE //////////////
//////////////////////////////

let atmMachine = ATMMachine()

atmMachine.insertCard()

atmMachine.ejectCard()

atmMachine.insertCard()

atmMachine.insertPin(enteredPin: 1234)

atmMachine.requestCash(withdrawAmount: 10)
