import UIKit

protocol Request {
    func request(with url: URL) -> Result<Data, Error>?
}

final class RequestImage: Request {
    func request(with url: URL) -> Result<Data, Error>? {
        // prepare imageRequest
        return nil
    }
}

final class RequestProduct: Request {
    func request(with url: URL) -> Result<Data, Error>? {
        // prepare product request
        return nil
    }
}


private enum Constants {
    static let imageURL = "https://media.pitchfork.com/photos/5cafb5476f99665c10beeb81/1:1/w_320/MacDemarco_HereComesTheCowboy.jpg"
}
