import UIKit

// Reference: https://medium.com/design-patterns-in-swift/design-patterns-in-swift-command-pattern-b95a1f4bbc45

////////////////////////
///// Command //////////
////////////////////////

// Command design pattern allows us to turn our commands into an object
// that will be responsible for executing the correct list of functions for
// a specific object without having to modify the object itself

protocol Command {
    func execute()
}

class ClockApp {
    func showClock() {
        print("Showing clock")
    }

    func removeClock(){
        print("Removing clock")
    }
}

class WeatherApp {

    func getWeatherData(){
        print("Getting weather data")
    }

    func showWeatherAnimation() {
        print("Showing correct weather animation")
    }

    func deleteWeatherData(){
        print("Deleting weather data")
    }

    func closeWeatherApp(){
        print("Closing weather app")
    }

}

// Makes use of composition to access WeatherApp
// Encapsulates all the beginner methos in the execute function
class WeatherAppOpenCommand : Command {
    let weatherApp: WeatherApp

    init(weatherApp : WeatherApp) {
        self.weatherApp = weatherApp
    }

    func execute() {
        self.weatherApp.getWeatherData()
        self.weatherApp.showWeatherAnimation()
    }

}

class WeatherAppCloseCommand : Command {
    let weatherApp: WeatherApp

    init(weatherApp: WeatherApp) {
        self.weatherApp = weatherApp
    }

    func execute() {
        self.weatherApp.deleteWeatherData()
        self.weatherApp.closeWeatherApp()
    }
}

class ClockAppOpenCommand : Command {
    let clockApp: ClockApp

    init(clockApp: ClockApp) {
        self.clockApp = clockApp
    }

    func execute() {
        self.clockApp.showClock()
    }

}

class ClockAppCloseCommand : Command {
    let clockApp: ClockApp

    init(clockApp: ClockApp) {
        self.clockApp = clockApp
    }

    func execute() {
        self.clockApp.removeClock()
    }
}


// Usage


class Springboard {
    private var openCommands = [Command]()
    private var closeCommands = [Command]()

    func addCommand(openCommand : Command, closeCommand : Command) {
        self.openCommands.append(openCommand)
        self.closeCommands.append(closeCommand)
    }

    func openApp(atIndex index : Int){
        if openCommands.count < index{
            print("App doesnt exist")
            return
        }
        openCommands[index].execute()
    }

    func closeApp(atIndex index : Int){
        if closeCommands.count < index{
            print("App doesnt exist")
            return
        }
        closeCommands[index].execute()
    }
}

let springboard = Springboard()
let weatherApp = WeatherApp()
let clockApp = ClockApp()

springboard.addCommand(openCommand: WeatherAppOpenCommand(weatherApp: weatherApp),
                       closeCommand: WeatherAppCloseCommand(weatherApp: weatherApp))
springboard.openApp(atIndex: 0)
springboard.closeApp(atIndex: 0)

springboard.addCommand(openCommand: ClockAppOpenCommand(clockApp: clockApp),
                       closeCommand: ClockAppCloseCommand(clockApp: clockApp))
springboard.openApp(atIndex: 1)
springboard.closeApp(atIndex: 1)
