import UIKit

// Reference: https://www.swiftbysundell.com/articles/using-the-builder-pattern-in-swift/

//////////////////////
// BUILDER PATTERN ///
//////////////////////


// Reduce the need to keep a mutable state - resulting in objects that are simpler and more predictable
// Enable objects to become stateless -> logic consists only of input & output

// Idea: the process of setting up an object is performed by another dedicated type
// and not the object itself


// Three major advantages
// 1. It lets us close down public API's: in the example above we could make text and textColor private
// 2. Prevents mutable state to be accidently shared
// 3. Hide complexity


// First example: set up a label

// Object setting its own properties
let label = UILabel()
label.backgroundColor = .red
label.text = "Introducing the builder pattern"
label.textColor = .green

// Object letting a builder change its properties

class LabelBuilder {
    let label = UILabel()

    @discardableResult
    func withTextColor(_ textColor: UIColor) -> LabelBuilder {
        label.textColor = textColor
        return self
    }

    @discardableResult
    func withText(_ text: String) -> LabelBuilder {
        label.text = text
        return self
    }

    @discardableResult
    func withBackgroundColor(_ color: UIColor) -> LabelBuilder {
        label.backgroundColor = color
        return self
    }

    func build() -> UILabel {
        return label
    }
}

let labelFromBuilder = LabelBuilder()
                            .withText("Introducing the builder pattern")
                            .withTextColor(UIColor.green)
                            .withBackgroundColor(UIColor.red)
                            .build()

// Discardable result let's us use this sintax without a warning

let labelBuilder = LabelBuilder()
labelBuilder.withText("How cool is discardable result?")
let label2 = labelBuilder.build()
