import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Properties
    private let signUpHeaderView = AuthHeaderView(title: "Sign Up", subtitle: "Create a new account", type: .signup)
    private let nameTextField = AuthTextField(fieldType: .name)
    private let usernameTextField = AuthTextField(fieldType: .username)
    private let emailTextField = AuthTextField(fieldType: .email)
    private let passwordTextField = AuthTextField(fieldType: .password)
    
    private lazy var backSignIn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleBackSignIn), for: .touchUpInside)
        button.tintColor = UIColor.label
        
        return button
    }()
    
    public lazy var signUpButton: UIButton = {
        let button = CButton(title: "Sign Up", hasBackground: true)
        button.backgroundColor = .label.withAlphaComponent(0.5)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    public var viewModel = SignUpViewModel()
    weak var delegate: AuthenticationDelegate?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureNotificationObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Helpers
    private func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(signUpHeaderView)
        
        self.view.addSubview(nameTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        
        self.view.addSubview(signUpButton)
        self.view.addSubview(backSignIn)
        
        signUpHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        backSignIn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.signUpHeaderView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 5),
            self.signUpHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signUpHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.signUpHeaderView.heightAnchor.constraint(equalToConstant: 210),
            
            self.nameTextField.topAnchor.constraint(equalTo: signUpHeaderView.bottomAnchor, constant: 0),
            self.nameTextField.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 55),
            self.nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            self.usernameTextField.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            self.emailTextField.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 55),
            self.emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            self.passwordTextField.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            self.signUpButton.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.backSignIn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.backSignIn.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor)
        ])
        
        self.signUpButton.addTarget(self, action: #selector(doSignUp), for: .touchUpInside)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.nameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        updateForm()
    }
    
    // MARK: - Actions
    @objc func textDidChange(sender: UITextField) {
        if sender == nameTextField {
            viewModel.name = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        } else if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    @objc private func doSignUp() {
        guard let name = nameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let credentials = AuthCredentials(name: name, username: username, email: email, password: password)
        
        showLoader(true)
        
        AuthService.signUp(withCredential: credentials) { error in
            
            self.showLoader(false)
            
            if let error = error {
                self.presentAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Done")
                return
            }
            
            self.presentAlertOnMainThread(title: "Success!", message: "Congratulations! You have successfully registered. Please sign in.", buttonTitle: "Done")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleBackSignIn() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignUpController()
}
