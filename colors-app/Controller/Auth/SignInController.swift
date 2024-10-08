import UIKit
import SafariServices

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

class SignInController: UIViewController {
    
    // MARK: - Properties
    private let signInHeaderView = AuthHeaderView(title: "Sign In", subtitle: "Welcome back!", type: .signin)
    private let emailTextField = AuthTextField(fieldType: .email)
    private let passwordTextField = AuthTextField(fieldType: .password)
    
    private lazy var goForgotPassword: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?")
        button.addTarget(self, action: #selector(handleGoForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var goContact: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Do you need help?", secondPart: "Contact Us")
        button.addTarget(self, action: #selector(handleGoContact), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var goSignUp: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleGoSignUp), for: .touchUpInside)
        
        return button
    }()
    
    public lazy var signInButton: UIButton = {
        let button = CButton(title: "Sign In", hasBackground: true)
        button.backgroundColor = .systemBrown.withAlphaComponent(0.5)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    public var viewModel = SignInViewModel()
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
    
    // Deinitializer
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
        
        self.view.addSubview(signInHeaderView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signInButton)
        self.view.addSubview(goForgotPassword)
        self.view.addSubview(goContact)
        self.view.addSubview(goSignUp)
        
        signInHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        goSignUp.translatesAutoresizingMaskIntoConstraints = false
        goForgotPassword.translatesAutoresizingMaskIntoConstraints = false
        goContact.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            self.goContact.topAnchor.constraint(equalTo: goForgotPassword.bottomAnchor, constant: 5),
            self.goContact.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
            
            self.goSignUp.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.goSignUp.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor)
        ])
        
        self.signInButton.addTarget(self, action: #selector(doSignIn), for: .touchUpInside)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        updateForm()
    }
    
    // MARK: - Actions
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    @objc private func doSignIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        showLoader(true)
        
        AuthService.signIn(withEmail: email, password: password) { result, error in
            
            self.showLoader(false)
            
            if let error = error {
                self.presentAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Done")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc private func handleGoContact() {
        if let url = URL(string: "https://www.example.com") {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc private func handleGoSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handleGoForgotPassword() {
        let controller = ResetPasswordController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignInController()
}
