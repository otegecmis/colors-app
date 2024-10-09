import UIKit

class CreateController: UIViewController, UIColorPickerViewControllerDelegate {
    
    // MARK: - Properties
    private var selectedColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var selectedColor: UIColor? = .systemGray6
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureViewController() {
        view.backgroundColor = .white
        
        title = "Create"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleCreateButton))
    }
    
    private func configureUI() {
        view.addSubview(selectedColorView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openColorPicker))
        
        selectedColorView.addGestureRecognizer(tapGesture)
        selectedColorView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            selectedColorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            selectedColorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            selectedColorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            selectedColorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        selectedColorView.layer.cornerRadius = 10
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        selectedColor = viewController.selectedColor
        selectedColorView.backgroundColor = selectedColor
    }
    
    // MARK: - Actions
    @objc func openColorPicker() {
        let colorPicker = UIColorPickerViewController()
        
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    @objc func handleCreateButton() {
        if let color = selectedColor {
            let hexString = color.toHexString()
            print("HEX: \(hexString)")
        } else {
            print("ERROR: No color selected.")
        }
    }
}
