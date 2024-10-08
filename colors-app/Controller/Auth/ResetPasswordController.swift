import UIKit

class ResetPasswordController: UIViewController {
    
    // MARK: - Properties
    private let signInHeaderView = AuthHeaderView(title: "Reset Password", subtitle: "Forgot your password?", type: .reset)
    private let emailTextField = AuthTextField(fieldType: .email)
    
    private lazy var backSignIn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleBackSignIn), for: .touchUpInside)
        
        return button
    }()
    
    public lazy var resetButton: UIButton = {
        let button = CButton(title: "Reset", hasBackground: true)
        button.backgroundColor = .systemBrown.withAlphaComponent(0.5)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    public var viewModel = ResetPasswordViewModel()
    
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
        self.view.addSubview(resetButton)
        self.view.addSubview(backSignIn)
        
        signInHeaderView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        backSignIn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.signInHeaderView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 5),
            self.signInHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signInHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.signInHeaderView.heightAnchor.constraint(equalToConstant: 210),
            
            self.emailTextField.topAnchor.constraint(equalTo: signInHeaderView.bottomAnchor, constant: 0),
            self.emailTextField.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 55),
            self.emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            self.resetButton.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor),
            self.resetButton.heightAnchor.constraint(equalToConstant: 55),
            self.resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.backSignIn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.backSignIn.centerXAnchor.constraint(equalTo: signInHeaderView.centerXAnchor)
        ])
        
        self.resetButton.addTarget(self, action: #selector(doReset), for: .touchUpInside)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        self.emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged )
        
        updateForm()
    }
    
    // MARK: - Actions
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        
        updateForm()
    }
    
    @objc private func doReset() {
        guard let email = emailTextField.text else { return }
        
        showLoader(true)
        
        AuthService.resetPassword(withEmail: email) { error in
            
            self.showLoader(false)
            
            if let error = error {
                self.presentAlertOnMainThread(title: "Error", message: error.localizedDescription, buttonTitle: "Done")
                return
            }
            
            self.presentAlertOnMainThread(title: "Success!", message: "Your password reset information has been sent to your email address. Please log in again after following the instructions.", buttonTitle: "Done")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleBackSignIn() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return ResetPasswordController()
}
