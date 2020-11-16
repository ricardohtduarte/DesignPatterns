import UIKit

// FACTORY METHOD:
// creational design pattern which solves the problem
// of creating product objects without specifying their concrete classes


// ABSTRACT FACTORY:

protocol VehicleViewControllerFactory {
    func makeBicycleViewController() -> UIViewController
    func makeScooterViewController() -> UIViewController
}

struct NewVehicleViewControllerFactory: VehicleViewControllerFactory {
    func makeBicycleViewController() -> UIViewController {
        return BicycleViewController(condition: .new)
    }
    func makeScooterViewController() -> UIViewController {
        return ScooterViewController(condition: .new)
    }
}

struct UsedVehicleViewControllerFactory: VehicleViewControllerFactory {
    func makeBicycleViewController() -> UIViewController {
        return BicycleViewController(condition: .used)
    }
    func makeScooterViewController() -> UIViewController {
        return ScooterViewController(condition: .used)
    }
}

enum VehicleCondition {
    case new
    case used
}

final class BicycleViewController: UIViewController {
    private let condition: VehicleCondition
    init(condition: VehicleCondition) {
        self.condition = condition
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("BicycleViewController: init(coder:) has not been implemented.")
    }
}

final class ScooterViewController: UIViewController {
    private let condition: VehicleCondition
    init(condition: VehicleCondition) {
        self.condition = condition
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("ScooterViewController: init(coder:) has not been implemented.")
    }
}

let factory: VehicleViewControllerFactory = NewVehicleViewControllerFactory()
let vc = factory.makeBicycleViewController()
