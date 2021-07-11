import UIKit

class ColorsConfiguratorViewController: UIViewController {
    @IBOutlet weak var currentColorView: UIView!

    @IBOutlet weak var redColorDisplay: UIView!
    @IBOutlet weak var greenColorDisplay: UIView!
    @IBOutlet weak var blueColorDisplay: UIView!

    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!

    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 20

        //Randomize initial slider values
        for slider in [redColorSlider, greenColorSlider, blueColorSlider] {
            slider?.value = Float.random(in: 0...1)
        }

        updateRedColor()
        updateGreenColor()
        updateBlueColor()

        setColor()
    }

    func setColor() {
        currentColorView.backgroundColor = UIColor(
            red: redColorSlider.value,
            green: greenColorSlider.value,
            blue: blueColorSlider.value
        )
    }

    func updateRedColor() {
        redColorValue.text = calcColorStringValue(redColorSlider.value)
        redColorDisplay.backgroundColor = UIColor(red: redColorSlider.value)
    }

    func updateGreenColor() {
        greenColorValue.text = calcColorStringValue(greenColorSlider.value)
        greenColorDisplay.backgroundColor = UIColor(green: greenColorSlider.value)
    }

    func updateBlueColor() {
        blueColorValue.text = calcColorStringValue(blueColorSlider.value)
        blueColorDisplay.backgroundColor = UIColor(blue: blueColorSlider.value)
    }

    @IBAction func redColorUpdated() {
        updateRedColor()
        setColor()
    }

    @IBAction func greenColorUpdated() {
        updateGreenColor()
        setColor()
    }

    @IBAction func blueColorUpdated() {
        updateBlueColor()
        setColor()
    }

    func calcColorStringValue(_ value: Float) -> String {
        "\(round(value * 100) / 100)"
    }

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
}

