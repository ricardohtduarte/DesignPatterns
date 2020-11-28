import UIKit

/////////////////////////////
///////// ADAPTER ///////////
/////////////////////////////

// Allows incompatible interfaces to work together

// Target: what the client expects the to work with (EnemyTank)

// Adapter: Makes the connection between two incompatible interfaces (EnemyRobotAdapter)

// Adaptee: Object that will actually be used by the client (EnemyRobot)

protocol EnemyAtacker {
    func fireWeapon()
    func driveForward()
    func assignDriver(driverName: String)
}

struct EnemyTank: EnemyAtacker {
    func fireWeapon() {
        print("Tank did 10 damage")
    }

    func driveForward() {
        print("Enemy tank moved")
    }

    func assignDriver(driverName: String) {
        print("\(driverName) was assign as a driver")
    }
}

struct EnemyRobotAdapter: EnemyAtacker {
    let robot: EnemyRobot

    func fireWeapon() {
        robot.smashWithHands()
    }

    func driveForward() {
        robot.walksForward()
    }

    func assignDriver(driverName: String) {
        robot.reactToHumans(driverName: driverName)
    }
}

struct EnemyRobot {
    func smashWithHands() {
        print("Robot did 10 damage")
    }

    func walksForward() {
        print("Enemy robot walked forward")
    }

    func reactToHumans(driverName: String) {
        print("Lol no humans here. \(driverName) gets killed")
    }
}




