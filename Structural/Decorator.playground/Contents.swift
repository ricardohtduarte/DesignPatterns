///////////////////////////////
////////// Composite //////////
///////////////////////////////

// Enables us to change objects dynamically
// Permits us to add funcationality by adding code rather by changing code
// More flexibility than inheritance

protocol Pizza {
    var description: String { get }
    var cost: Double { get }
}

class PlainPizza: Pizza {
    let description: String = "Thin dough"
    let cost: Double = 4.0
}

class ToppingDecorator: Pizza {
    var description: String {
        pizzaInProgress.description
    }
    var cost: Double {
        pizzaInProgress.cost
    }

    let pizzaInProgress: Pizza

    init(newPizza: Pizza) {
        self.pizzaInProgress = newPizza
    }
}

class Mozarella: ToppingDecorator {
    override init(newPizza: Pizza) {
        super.init(newPizza: newPizza)
    }

    override var description: String {
        pizzaInProgress.description + ", Mozarella"
    }

    override var cost: Double {
        pizzaInProgress.cost + 2.0
    }
}

class TomatoSauce: ToppingDecorator {
    override init(newPizza: Pizza) {
        super.init(newPizza: newPizza)
    }

    override var description: String {
        pizzaInProgress.description + ", Tomato Sauce"
    }

    override var cost: Double {
        pizzaInProgress.cost + 1.0
    }
}

let myPizza = TomatoSauce(newPizza: Mozarella(newPizza: PlainPizza()))

print(myPizza.description)
print(myPizza.cost)
