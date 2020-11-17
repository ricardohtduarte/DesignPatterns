import UIKit
import Foundation

// Reference: https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift

//////////////////////
///// SINGLETON //////
//////////////////////


// Pattern that ensures that only one instance of the objects is shared
// throughout the codebase

// First approach: Global Variable

let urlSession = URLSession(configuration: .default)

// Second approach: Static property

class CustomURLSession {
    static let shared = URLSession(configuration: .default)

    let configuration: URLSessionConfiguration

    private init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
}

// Advantages:
// - It's always clear what it's doing
// - Easily accessed throughout the project

// Disadvantages:
// - Testing/Dependency hiding: cannot isolate class dependency, they usually introduce tight coupling
// - Concurrency: multiple proccess might try to access the same resource

