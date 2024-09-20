import UIKit

// MARK: - UITabBarController
extension UITabBarController {
    
    func navigationTabController(title: String, image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        let appearance = UITabBar.appearance()
        
        nav.title = title
        nav.view.backgroundColor = .systemBackground
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage?.withTintColor(UIColor.blue)
        appearance.tintColor = .systemBlue
        
        return nav
    }
}
