import UIKit

// Specialized Factory to handle initialization

enum Condition {
    case new
    case used
}

enum EngineType {
    case diesel
    case gas
}

struct Engine {
    let type: EngineType
}

enum TransmissionType {
    case automatic
    case manual
}

final class CarViewController: UIViewController {
    private let condition: Condition
    private let engine: Engine
    private let transmission: TransmissionType
    private let wheelDiameter: Int
    init(engine: Engine,
         transmission: TransmissionType,
         wheelDiameter: Int = 16,
         condition: Condition = .new) {
        self.engine = engine
        self.transmission = transmission
        self.wheelDiameter = wheelDiameter
        self.condition = condition
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("CarViewController: init(coder:) has not been implemented.")
    }
}

// We can initialize the ViewController directly

let engineType = EngineType.diesel
let engine = Engine(type: engineType)
let transmission = TransmissionType.automatic
let wheelDiameter = 18


let viewController = CarViewController(engine: engine,
                                       transmission: transmission,
                                       wheelDiameter: wheelDiameter)

// Or create a specialized Factory
// This enables us to hide initialization logic

struct UsedCarViewControllerFactory {
    let engineType: EngineType
    let transmissionType: TransmissionType
    let wheelDiameter: Int

    func makeCarViewController() -> UIViewController {
        let engine = Engine(type: engineType)
        return CarViewController(engine: engine,
                                 transmission: transmissionType,
                                 wheelDiameter: wheelDiameter,
                                 condition: .used)
    }
}

let carFactory = UsedCarViewControllerFactory(engineType: .gas, transmissionType: .manual, wheelDiameter: 17)
let viewControllerThroughFactory = carFactory.makeCarViewController()
