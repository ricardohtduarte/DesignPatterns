import UIKit

// Reference: https://medium.com/flawless-app-stories/strategy-pattern-in-swift-1462dbddd9fe

////////////////////////
/////// Strategy ///////
////////////////////////

// The Strategy pattern is a behavioral software design pattern that enables selecting an algorithm at runtime. Instead of implementing a single algorithm directly, code receives run-time instructions as to which in a family of algorithms to use.


struct Logger {
    enum LogStyle {
        case lowercase
        case uppercase
        case capitalized
    }

    let style: LogStyle

    func log(_ message: String) {
        switch style {
        case .lowercase:
            print(message.lowercased())
        case .uppercase:
            print(message.uppercased())
        case .capitalized:
            print(message.capitalized)
        }
    }
}

// In this case, to add a log style we would have to change code in the Enum and also in the log function
// In here we can avoid this by using the strategy pattern

// What
protocol LoggerStrategy {
    func log(_ message: String)
}

// Who
struct LoggerV2 {
    let strategy: LoggerStrategy

    func log(_ message: String) {
        strategy.log(message)
    }
}

// How
struct Lowercase: LoggerStrategy {
    func log(_ message: String) {
        print(message.lowercased())
    }
}

struct Uppercase: LoggerStrategy {
    func log(_ message: String) {
        print(message.uppercased())
    }
}

struct Capitalized: LoggerStrategy {
    func log(_ message: String) {
        print(message.capitalized)
    }
}

struct NewRandomLog: LoggerStrategy {
    func log(_ message: String) {
        print(message + "Random stuff lol")
    }
}

var logger = LoggerV2(strategy: Lowercase())
logger.log("my first strategy")
logger = LoggerV2(strategy: Uppercase())
logger.log("my first strategy")
logger = LoggerV2(strategy: Capitalized())
logger.log("my first strategy")
