import UIKit

//////////////////////
// BUILDER PATTERN ///
//////////////////////


// Reduce the need to keep a mutable state - resulting in objects that are simpler and more predictable
// Enable objects to become stateless -> logic consists only of input & output

// Idea: the process of setting up an object is performed by another dedicated type
// and not the object itself


// First example: set up a label

// Object setting its own properties
let label = UILabel()
label.backgroundColor = .red
label.text = "Introducing the builder pattern"
label.textColor = .green

// Object letting a builder change its properties

class LabelBuilder {
    let label = UILabel()

    func withTextColor(_ textColor: UIColor) -> LabelBuilder {
        label.textColor = textColor
        return self
    }

    func withText(_ text: String) -> LabelBuilder {
        label.text = text
        return self
    }

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


