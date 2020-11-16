import UIKit

// FACTORY METHOD a.k.a VIRTUAL CONSTRUCTOR

// Move methods with similar implementation but with different
// return types up in the hierarchy

final class BicycleViewController: UIViewController { }
final class ScooterViewController: UIViewController { }

protocol Coordinator {
    var presentingViewController: UIViewController? { get set }
    func start()
    func makeViewController() -> UIViewController
}

extension Coordinator {
    func start() {
        let vc = makeViewController()
        presentingViewController?.present(vc, animated: true)
    }
}

final class BicycleCoordinator: Coordinator {
    weak var presentingViewController: UIViewController?
    func makeViewController() -> UIViewController {
        return BicycleViewController()
    }
}

final class ScooterCoordinator: Coordinator {
    weak var presentingViewController: UIViewController?
    func makeViewController() -> UIViewController {
        return ScooterViewController()
    }
}
