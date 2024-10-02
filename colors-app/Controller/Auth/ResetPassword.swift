import UIKit

class ResetPassword: UIViewController {
    
    // MARK: - Properties
    private let signInHeaderView = AuthHeaderView(title: "Reset Password", subtitle: "Forgot your password?", type: .reset)
    
    private let emailTextField = AuthTextField(fieldType: .email)
    
    private let resetButton = CButton(title: "Reset", hasBackground: true)
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
    }
    
    // MARK: - Actions
    @objc private func doReset() {
        presentAlertOnMainThread(title: "Warning", message: "Reset password is not implemented yet.", buttonTitle: "Done")
        return
    }
    
    @objc private func handleBackSignIn() {
        navigationController?.popViewController(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    return ResetPassword()
}
