import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let latest = navigationTabController(title: "Latest", image: UIImage(systemName: "paintpalette"), rootViewController: LatestController())
        let create = navigationTabController(title: "Create", image: UIImage(systemName: "paintbrush"), rootViewController: CreateController())
        let random = navigationTabController(title: "Random", image: UIImage(systemName: "swatchpalette"), rootViewController: RandomController())
        let profile = navigationTabController(title: "Profile", image: UIImage(systemName: "theatermask.and.paintbrush"), rootViewController: profileController)
        
        viewControllers = [latest, create, random, profile]
    }
}

// MARK: - AuthenticationDelegate
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

@available(iOS 17.0, *)
#Preview {
    return MainTabController()
}
