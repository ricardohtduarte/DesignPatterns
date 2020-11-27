import UIKit

// Reference: https://learnappmaking.com/notification-center-how-to-swift/

////////////////////////////////////////////////////
/////// Observer using Notification center /////////
////////////////////////////////////////////////////

let notificationName = Notification.Name(rawValue: "com.stock.oberservation")
let appleStockPriceName = "appleStockPrice"

final class Server {
    var appleStockPrice: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: notificationName,
                                            object: self,
                                            userInfo: [appleStockPriceName: appleStockPrice])
        }
    }
}

final class Client {
    var totalAppleStockPrice: Int = 0 {
        didSet {
            print("Apple's total stock price was updated to \(totalAppleStockPrice)")
        }
    }

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(incrementTotalStockPrice),
                                               name: notificationName,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    func incrementTotalStockPrice(notification: Notification) {
        guard
            let userInfo = notification.userInfo as? [String: Int],
            let appleStockPrice = userInfo[appleStockPriceName] else {
                return
        }
        totalAppleStockPrice += appleStockPrice
    }
}

let server = Server()
let client = Client()

server.appleStockPrice = 200
server.appleStockPrice = 90




