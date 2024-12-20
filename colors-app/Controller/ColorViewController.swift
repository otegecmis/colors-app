import UIKit
import FirebaseAuth

final class ColorViewController: UIViewController {
    
    // MARK: - Properties
    var color: Color?
    var user: User?
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var hexLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    private lazy var usernameLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    private lazy var hexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No color selected."
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        
        return label
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
        hideIfNotOwner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Helpers
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Color View"
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleDeleteButton))
        navigationItem.rightBarButtonItem = deleteButton
    }
    
    private func configureUI() {
        if let color = color {
            colorView.backgroundColor = UIColor(hex: color.hex)
        }
        
        view.addSubview(colorView)
        view.addSubview(hexLabelView)
        view.addSubview(hexLabel)
        view.addSubview(usernameLabelView)
        view.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            colorView.bottomAnchor.constraint(equalTo: hexLabelView.topAnchor, constant: 0),
            colorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            colorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            hexLabelView.topAnchor.constraint(equalTo: colorView.bottomAnchor),
            hexLabelView.bottomAnchor.constraint(equalTo: usernameLabelView.topAnchor),
            hexLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            hexLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            hexLabelView.heightAnchor.constraint(equalToConstant: 50),
            
            hexLabel.leadingAnchor.constraint(equalTo: hexLabelView.leadingAnchor, constant: 10),
            hexLabel.centerYAnchor.constraint(equalTo: hexLabelView.centerYAnchor),
            
            usernameLabelView.topAnchor.constraint(equalTo: hexLabelView.bottomAnchor),
            usernameLabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            usernameLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            usernameLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            usernameLabelView.heightAnchor.constraint(equalToConstant: 30),
            
            usernameLabel.leadingAnchor.constraint(equalTo: usernameLabelView.leadingAnchor, constant: 10),
            usernameLabel.centerYAnchor.constraint(equalTo: usernameLabelView.centerYAnchor),
        ])
        
        guard let username = color?.username else { return }
        
        hexLabel.text = color?.hex
        usernameLabel.text = "@\(username)"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.goUser(_ :)))
        
        self.usernameLabel.isUserInteractionEnabled = true
        self.usernameLabel.addGestureRecognizer(tapGesture)
    }
    
    func hideIfNotOwner() {
        if user?.username != color?.username  {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    // MARK: - Actions
    @objc func goUser(_ sender: UITapGestureRecognizer) {
        guard let uid = color?.userUID else { return }
        
        UserService.fetchUser(withUid: uid) { user in
            let profileController = ProfileController()
            profileController.user = user
            
            self.navigationController?.pushViewController(profileController, animated: true)
        }
    }
    
    @objc func handleDeleteButton() {
        guard let colorToDelete = self.color else {
            self.presentAlertOnMainThread(title: "Done", message: "No color selected to delete.", buttonTitle: "Done")
            return
        }
        
        ColorService.deleteColor(color: colorToDelete) { error in
            if let error = error {
                self.presentAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Done")
                return
            }
            
            self.presentAlertOnMainThread(title: "Success!", message: "Color deleted successfully.", buttonTitle: "Done")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
