import UIKit

//////////////////////////////
///////// DELEGATE ///////////
//////////////////////////////


// As the name suggests, the delegate pattern allows us to delegate work to other object
// This creates a connection between two objects which allows them to communicate and transfer data


// Main class:
class MyClassThatDoesStuff {
    var mutableString: String

    init() {
        mutableString = "Something that needs to be capitalized"
    }
}

extension MyClassThatDoesStuff: Logger {
    func capitalizeString() {
        mutableString = mutableString.capitalized
    }
    
    func lowercasedString() {
        mutableString = mutableString.lowercased()
    }
    
    func uppercasedString() {
        mutableString = mutableString.uppercased()
    }
}


// Delegate protocol

protocol Logger: class {
    func capitalizeString()
    func lowercasedString()
    func uppercasedString()
}

// Object that will process the string
class StringHandler {
    weak var delegate: Logger?
    var currentState: LogType = .capitalized

    init() {
        switch currentState {
        case .lowercase:
            delegate?.lowercasedString()
        case .uppercase:
            delegate?.uppercasedString()
        case .capitalized:
            delegate?.capitalizeString()
        }
    }
}

enum LogType {
    case capitalized
    case lowercase
    case uppercase
}
