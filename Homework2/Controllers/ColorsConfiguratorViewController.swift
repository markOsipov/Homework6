import UIKit

class ColorsConfiguratorViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var colorsConfiguratorView: UIView!
    @IBOutlet weak var currentColorView: UIView!

    @IBOutlet weak var redColorDisplay: UIView!
    @IBOutlet weak var greenColorDisplay: UIView!
    @IBOutlet weak var blueColorDisplay: UIView!

    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!

    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!

    @IBOutlet weak var doneButton: UIButton!

    var redColorStartValue: Float = Float.random(in: 0...1)
    var greenColorStartValue: Float = Float.random(in: 0...1)
    var blueColorStartValue: Float = Float.random(in: 0...1)

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorView = segue.destination as? ColorViewController else {
            return
        }
        colorView.redColorValue = redColorSlider.value
        colorView.greenColorValue = greenColorSlider.value
        colorView.blueColorValue = blueColorSlider.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currentColorView.layer.cornerRadius = 20

        redColorSlider.value = redColorStartValue
        greenColorSlider.value = greenColorStartValue
        blueColorSlider.value = blueColorStartValue

        updateColor(.red, source: .slider)
        updateColor(.green, source: .slider)
        updateColor(.blue, source: .slider)

        setColor()
    }

    @IBAction func redColorUpdated() {
        updateColor(.red, source: .slider)
        setColor()
    }

    @IBAction func greenColorUpdated() {
        updateColor(.green, source: .slider)
        setColor()
    }

    @IBAction func blueColorUpdated() {
        updateColor(.blue, source: .slider)
        setColor()
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "returnToColorView", sender: self)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {

        case redColorTextField:
            updateColor(.red, source: .textField)

        case greenColorTextField:
            updateColor(.green, source: .textField)

        case blueColorTextField:
            updateColor(.blue, source: .textField)

        default: return true
        }
        setColor()
        colorsConfiguratorView.endEditing(true)

        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        colorsConfiguratorView.endEditing(true)
    }

    func setColor() {
        currentColorView.backgroundColor = UIColor(
            red: redColorSlider.value,
            green: greenColorSlider.value,
            blue: blueColorSlider.value
        )
    }

    func updateColor(_ color: Color, source: ChangeColorSource) {
        var textField: UITextField = redColorTextField
        var slider: UISlider = redColorSlider
        var displayView: UIView = redColorDisplay

        switch color {
        case .red :
            textField = redColorTextField
            slider = redColorSlider
            displayView = redColorDisplay

        case .green:
            textField = greenColorTextField
            slider = greenColorSlider
            displayView = greenColorDisplay

        case .blue:
            textField = blueColorTextField
            slider = blueColorSlider
            displayView = blueColorDisplay
        }

        switch source {
        case .slider:
            textField.text = calcColorStringValue(slider.value)
        case .textField:
            if let value: Float = Float(textField.text ?? "") {
                if (value >= 0 && value <= 1) {
                    slider.value = value
                } else {
                    showAlert("Color value shoud be between 0 and 1")
                }
            } else {
                showAlert("Wrong number in \(color.rawValue) color textfield")
            }
        }

        displayView.backgroundColor = UIColor(color: color, value: slider.value)
    }

    func calcColorStringValue(_ value: Float) -> String {
        "\(round(value * 100) / 100)"
    }

    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

enum ChangeColorSource {
    case slider
    case textField
}


