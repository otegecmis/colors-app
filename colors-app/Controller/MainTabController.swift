import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    func configureViewControllers() {
        view.backgroundColor = .systemBackground
        
        let latest = templateNavigationController(title: "Latest", image: UIImage(systemName: "paintpalette"), rootViewController: LatestController())
        let random = templateNavigationController(title: "Random", image: UIImage(systemName: "swatchpalette"), rootViewController: RandomController())
        let profile = templateNavigationController(title: "Profile", image: UIImage(systemName: "person.crop.circle"), rootViewController: ProfileController())
        
        viewControllers = [latest, random, profile]
    }
    
    func templateNavigationController(title: String, image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
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

@available(iOS 17.0, *)
#Preview {
    let mainTabController = MainTabController()
    return mainTabController
}
