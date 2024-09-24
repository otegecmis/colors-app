import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Properties
    private let signUpHeaderView = AuthHeaderView(title: "Sign Up", subtitle: "Create a new account", type: .signup)
    
    private let nameTextField = AuthTextField(fieldType: .name)
    private let usernameTextField = AuthTextField(fieldType: .username)
    private let emailTextField = AuthTextField(fieldType: .email)
    private let passwordTextField = AuthTextField(fieldType: .password)
    
    private let signUpButton = CButton(title: "Sign Up", hasBackground: true, fontSize: .med)
    
    private lazy var backSignIn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleBackSignIn), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Helpers
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
            self.signUpHeaderView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10),
            self.signUpHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signUpHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.signUpHeaderView.heightAnchor.constraint(equalToConstant: 222),
            
            self.nameTextField.topAnchor.constraint(equalTo: signUpHeaderView.bottomAnchor, constant: 15),
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
            
            self.backSignIn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            self.backSignIn.centerXAnchor.constraint(equalTo: signUpHeaderView.centerXAnchor)
        ])
        
        self.signUpButton.addTarget(self, action: #selector(doSignUp), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func doSignUp() {
        print("DEBUG: doSignUp()")
    }
    
    @objc private func handleBackSignIn() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignUpController()
}
