import UIKit

// MARK: - UIViewController
extension UIViewController {
    
    // MARK: - Helpers
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.completion = completion
            self.present(alertVC, animated: true)
        }
    }
}

// MARK: - UITabBarController
extension UITabBarController {
    
    // MARK: - Helpers
    func navigationTabController(title: String, image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        let appearance = UITabBar.appearance()
        
        nav.title = title
        nav.view.backgroundColor = .systemBackground
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage?.withTintColor(UIColor.systemBrown)
        appearance.tintColor = .systemBrown
        
        return nav
    }
}

// MARK: - UIButton
extension UIButton {
    
    // MARK: - Helpers
    func attributedTitle(firstPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemBrown, .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func attributedTitle(firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemBrown, .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemBrown, .font: UIFont.boldSystemFont(ofSize: 16)]
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
