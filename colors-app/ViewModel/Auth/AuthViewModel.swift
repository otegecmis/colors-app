import UIKit

protocol FormViewModel {
    
    // MARK: - Helpers
    func updateForm()
}

protocol AuthViewModel {
    
    // MARK: - Properties
    var formIsValid: Bool { get }
    var buttonBGColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}
