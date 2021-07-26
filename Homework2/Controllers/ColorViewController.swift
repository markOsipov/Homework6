import UIKit

class ColorViewController: UIViewController {
    @IBOutlet var colorView: UIView!

    var redColorValue: Float = Float.random(in: 0...1)
    var greenColorValue: Float = Float.random(in: 0...1)
    var blueColorValue: Float = Float.random(in: 0...1)

    override func viewDidLoad() {
        colorView.backgroundColor = UIColor(
            red: redColorValue,
            green: greenColorValue,
            blue: blueColorValue
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let configuratorVC = segue.destination as? ColorsConfiguratorViewController else {
            return
        }
        
        configuratorVC.redColorStartValue = redColorValue
        configuratorVC.greenColorStartValue = greenColorValue
        configuratorVC.blueColorStartValue = blueColorValue
    }
}
