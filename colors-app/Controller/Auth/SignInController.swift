import UIKit

class SignInController: UIViewController {
    
    // MARK: - Properties
    private let signInHeaderView = AuthHeaderView(title: "Sign In", subtitle: "Welcome back!", type: .signin)
    
    private let emailTextField = AuthTextField(fieldType: .email)
    private let passwordTextField = AuthTextField(fieldType: .password)
    
    private let signInButton = CButton(title: "Sign In", hasBackground: true)
    
    private lazy var goForgotPassword: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?")
        button.addTarget(self, action: #selector(handleGoForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var goSignUp: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleGoSignUp), for: .touchUpInside)
        
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
        
        self.view.addSubview(signInHeaderView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        self.view.addSubview(goForgotPassword)
        self.view.addSubview(goSignUp)
        
        signInHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        goSignUp.translatesAutoresizingMaskIntoConstraints = false
        goForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.signInHeaderView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 5),
            self.signInHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signInHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.signInHeaderView.heightAnchor.constraint(equalToConstant: 210),
            
            self.emailTextField.topAnchor.constraint(equalTo: signInHeaderView.bottomAnchor, constant: 0),
            self.emailTextField.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 55),
            self.emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            self.passwordTextField.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            self.signInButton.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.goForgotPassword.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 15),
            self.goForgotPassword.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
    
            self.goSignUp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            self.goSignUp.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor)
        ])
        
        self.signInButton.addTarget(self, action: #selector(doSignIn), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func doSignIn() {
        print("DEBUG: doSignIn()")
    }
    
    @objc private func handleGoSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handleGoForgotPassword() {
        let controller = ResetPassword()
        navigationController?.pushViewController(controller, animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignInController()
}
