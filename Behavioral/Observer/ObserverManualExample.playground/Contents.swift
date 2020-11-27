import UIKit

//////////////////////////////////////
/////////////  OBSERVER //////////////
//////////////////////////////////////


// Use observer when we need other objects to receive an update when another object changes
// Example: Notification Center from Foundation

// Subject (publisher): sends the notifications
// Observers (subscribers): receive the update from the publisher they are subscribed to

protocol Subject: class {
    func register(observer: Observer)
    func remove(observer: Observer)
    func notify()
}

protocol Observer {
    func update(ibmPrice: Double, applePrice: Double, googlePrice: Double)
}

final class StockManager {
    private var observers: [Observer] = []

    private var ibmPrice: Double = 0
    private var applePrice: Double = 0
    private var googlePrice: Double = 0

    init() {}

    func setPrices(ibmPrice: Double, applePrice: Double, googlePrice: Double) {
        self.ibmPrice = ibmPrice
        self.applePrice = applePrice
        self.googlePrice = googlePrice
        notify()
    }
}

extension StockManager: Subject {
    func register(observer: Observer) {
        observers.append(observer)
    }

    func remove(observer: Observer) {
        guard let indexToRemove = observers.firstIndex(where: { $0 as AnyObject === observer as AnyObject }) else {
            return
        }
        observers.remove(at: indexToRemove)
    }

    func notify() {
        observers.forEach({ $0.update(ibmPrice: ibmPrice, applePrice: applePrice, googlePrice: googlePrice) })
    }
}

final class StockObserver {
    private var ibmPrice: Double = 0 {
        didSet {
            print("ibmPrice was updated from \(oldValue) to \(ibmPrice)")
        }
    }
    private var applePrice: Double = 0 {
        didSet {
            print("applePrice was updated from \(oldValue) to \(applePrice)")
        }
    }
    private var googlePrice: Double = 0 {
        didSet {
            print("googlePrice was updated from \(oldValue) to \(googlePrice)")
        }
    }

    init(subject: Subject) {
        subject.register(observer: self)
    }
}

extension StockObserver: Observer {
    func update(ibmPrice: Double, applePrice: Double, googlePrice: Double) {
        self.ibmPrice = ibmPrice
        self.applePrice = applePrice
        self.googlePrice = googlePrice
    }
}

let stockManager = StockManager()
let stockObserver = StockObserver(subject: stockManager)

stockManager.setPrices(ibmPrice: 10, applePrice: 20, googlePrice: 12)


