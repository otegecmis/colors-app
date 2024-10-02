import UIKit

extension ResetPassword {
    
    // MARK: - Keyboard Handling
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
