import UIKit

struct SignInViewModel: AuthViewModel {
    
    // MARK: - Properties
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBGColor: UIColor {
        return formIsValid ? .systemBrown : .systemBrown.withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}