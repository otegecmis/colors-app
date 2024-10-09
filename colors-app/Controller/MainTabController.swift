import UIKit
import FirebaseAuth

final class MainTabController: UITabBarController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    private let createPlaceholderController = UIViewController()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        checkIfUserIsLoggedIn()
        fetchUser()
    }
    
    // MARK: - Service
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
    
    // MARK: - Helpers
    func checkIfUserIsLoggedIn() {
        let currentUser = Auth.auth().currentUser
        
        if currentUser  == nil {
            DispatchQueue.main.async {
                let signInController = SignInController()
                signInController.delegate = self
                let nav = UINavigationController(rootViewController: signInController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func configureViewControllers(withUser user: User) {
        view.backgroundColor = .systemBackground
        
        let profileController = ProfileController()
        
        profileController.user = self.user
        profileController.tabBarItem.title = "Profile"
        
        createPlaceholderController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "paintbrush"), selectedImage: nil)

        let latest = navigationTabController(title: "Latest", image: UIImage(systemName: "paintpalette"), rootViewController: LatestController())
        let random = navigationTabController(title: "Random", image: UIImage(systemName: "swatchpalette"), rootViewController: RandomController())
        let profile = navigationTabController(title: "Profile", image: UIImage(systemName: "theatermask.and.paintbrush"), rootViewController: profileController)
        
        viewControllers = [latest, createPlaceholderController, random, profile]
    }
    
    // MARK: - Actions
    private func presentCreateController() {
        let createController = CreateController()
        let navigationController = UINavigationController(rootViewController: createController)
        
        navigationController.modalPresentationStyle = .pageSheet
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - AuthenticationDelegate
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == createPlaceholderController {
            presentCreateController()
            return false
        }
        return true
    }
}

@available(iOS 17.0, *)
#Preview {
    return MainTabController()
}
