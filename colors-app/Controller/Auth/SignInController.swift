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
    
    private lazy var goContact: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Do you need help?", secondPart: "Contact Us")
        
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
        self.configureKeyboardHandling()
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
    private func configureKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
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
    }
    
    // MARK: - Actions
    @objc private func doSignIn() {
        presentAlertOnMainThread(title: "Warning", message: "Sign in is not implemented yet.", buttonTitle: "Done")
        return
    }
    
    @objc private func handleGoSignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handleGoForgotPassword() {
        let controller = ResetPassword()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Keyboard Handling
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 3
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return SignInController()
}
