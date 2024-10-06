import UIKit

extension ResetPasswordController {
    
    // MARK: - Keyboard Handling
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ResetPasswordController: FormViewModel {
 
    // MARK: - Helpers
    func updateForm() {
        resetButton.backgroundColor = viewModel.buttonBGColor
        resetButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        resetButton.isEnabled = viewModel.formIsValid
    }
}
