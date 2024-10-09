import UIKit

final class RandomController: UIViewController {
    
    // MARK: - Properties
    var color: UIColor?
    
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
        label.text = "@username"
        label.textAlignment = .center
        label.font = label.font.withSize(12)
        
        return label
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getColor()
        configureViewController()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getColor()
        
        if let color = color {
            colorView.backgroundColor = color
            hexLabel.text = color.toHexString()
            usernameLabel.text = "@username"
        }
    }
    
    // MARK: - Helpers
    private func getColor() {
        color = MOCK_COLORS.shuffled().first
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Random"
    }
    
    private func configureUI() {
        if let color = color {
            colorView.backgroundColor = color
        }
        
        view.addSubview(colorView)
        view.addSubview(hexLabelView)
        view.addSubview(hexLabel)
        view.addSubview(usernameLabelView)
        view.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
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
            usernameLabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            usernameLabelView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            usernameLabelView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            usernameLabelView.heightAnchor.constraint(equalToConstant: 30),
            
            usernameLabel.leadingAnchor.constraint(equalTo: usernameLabelView.leadingAnchor, constant: 10),
            usernameLabel.centerYAnchor.constraint(equalTo: usernameLabelView.centerYAnchor),
        ])
        
        hexLabel.text = color?.toHexString()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goUser))
        
        usernameLabelView.addGestureRecognizer(tapGesture)
        usernameLabelView.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    @objc func goUser() {
        print("DEBUG: goUser()")
    }
}
