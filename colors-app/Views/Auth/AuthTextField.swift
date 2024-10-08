import UIKit

class AuthTextField: UITextField {
    
    // MARK: - Properties
    enum CustomTextFieldType {
        case username
        case email
        case password
        case name
    }
    
    // MARK: - Initializers
    init(fieldType: CustomTextFieldType) {
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.clearButtonMode = .always
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        customize(fieldType: fieldType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func customize(fieldType: CustomTextFieldType) {
        switch fieldType {
        case .name:
            self.placeholder = "Name"
        case .username:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Email Address"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
}
