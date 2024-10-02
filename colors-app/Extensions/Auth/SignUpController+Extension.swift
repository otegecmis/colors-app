import UIKit

extension SignUpController {
    
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


extension SignUpController: FormViewModel {
    
    // MARK: - Helpers
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBGColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}
