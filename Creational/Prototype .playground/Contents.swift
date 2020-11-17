import UIKit

// Reference: https://theswiftdev.com/swift-prototype-design-pattern/

////////////////////////
///// PROTOTYPE ////////
////////////////////////


// Allows the cloning process of objects without coupling to their specific classes

// Advantages
// 1. No need for subclassing
// 2. Only needs a default init
// 3. Useful when trying to create snapshots of a specific state

class Paragraph {

    var font: UIFont
    var color: UIColor
    var text: String

    init(font: UIFont = UIFont.systemFont(ofSize: 12),
         color: UIColor = .darkText,
         text: String = "") {

        self.font = font
        self.color = color
        self.text = text
    }

    func clone() -> Paragraph {
        return Paragraph(font: self.font, color: self.color, text: self.text)
    }
}

let base = Paragraph()

let title = base.clone()
title.font = UIFont.systemFont(ofSize: 18)
title.text = "This is the title"

let first = base.clone()
first.text = "This is the first paragraph"

let second = base.clone()
second.text = "This is the second paragraph"

