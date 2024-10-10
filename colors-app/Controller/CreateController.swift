import UIKit
import Firebase

final class CreateController: UIViewController, UIColorPickerViewControllerDelegate {
    
    // MARK: - Properties
    private lazy var selectedColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tapLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        label.text = "Tap"
        
        return label
    }()
    
    private lazy var createBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleCreateBarButton))
    private var selectedColor: UIColor? = .systemGray6 {
        didSet {
            createBarButton.isEnabled = true
            tapLabel.isHidden = true
            selectedColorView.layer.borderWidth = 0
        }
    }
    
    var user: User?
    
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
        navigationItem.rightBarButtonItem = createBarButton
        createBarButton.isEnabled = false
    }
    
    private func configureUI() {
        view.addSubview(selectedColorView)
        view.addSubview(tapLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openColorPicker))
        
        selectedColorView.addGestureRecognizer(tapGesture)
        selectedColorView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            selectedColorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            selectedColorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            selectedColorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            selectedColorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            tapLabel.centerYAnchor.constraint(equalTo: selectedColorView.centerYAnchor),
            tapLabel.centerXAnchor.constraint(equalTo: selectedColorView.centerXAnchor)
        ])
        
        selectedColorView.layer.cornerRadius = 10
        selectedColorView.layer.borderColor = UIColor.label.cgColor
        selectedColorView.layer.borderWidth = 2
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
    
    @objc func handleCreateBarButton() {
        guard let color = selectedColor else {
            self.presentAlertOnMainThread(title: "Error", message: "No color selected.", buttonTitle: "Done")
            return
        }
        
        let uid = UUID().uuidString
        let hex = color.toHexString()
        guard let username = user?.username else { return }
        guard let userUID = user?.uid else { return }
        let timestamp = Timestamp(date: Date())
        
        let colorData: [String: Any] = [
            "uid": uid,
            "hex": hex,
            "username": username,
            "userUID": userUID,
            "timestamp": timestamp
        ]
        
        showLoader(true)
        
        ColorService.createColor(color: Color(dictionary: colorData)) { error in
            self.showLoader(false)
            
            if let error = error {
                DispatchQueue.main.async {
                    self.presentAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Done")
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.presentAlertOnMainThread(title: "Success!", message: "Congratulations! Color successfully created!", buttonTitle: "Done") {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}
