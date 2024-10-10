import UIKit

extension SignInController {
    
    // MARK: - Keyboard Handling
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 3
                self.signInHeaderView.hideIconImageView()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            self.signInHeaderView.showIconImageView()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SignInController: FormViewModel {
    
    // MARK: - Helpers
    func updateForm() {
        signInButton.backgroundColor = viewModel.buttonBGColor
        signInButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signInButton.isEnabled = viewModel.formIsValid
    }
}
