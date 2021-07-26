import UIKit

enum Color: String {
    case red = "red"
    case green = "green"
    case blue = "blue"
}

extension UIColor {
    convenience init(red: Float = 0.0,
                     green: Float = 0.0,
                     blue: Float = 0.0,
                     alpha: Float = 1.0) {
        self.init(
            displayP3Red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(alpha)
        )
    }

    convenience init(color: Color, value: Float) {
        switch color {
        case .red:
            self.init(red: value)
        case .green:
            self.init(green: value)
        case .blue:
            self.init(blue: value)
        }
    }
}
