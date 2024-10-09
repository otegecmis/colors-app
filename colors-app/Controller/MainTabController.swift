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
    
    lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .label
        button.setImage(UIImage(systemName: "paintbrush"), for: .normal)
        
        button.addTarget(self, action: #selector(handleFloatingButton), for: .touchUpInside)
        
        return button
    }()
    
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
        let random = navigationTabController(title: "Random", image: UIImage(systemName: "swatchpalette"), rootViewController: RandomController())
        let profile = navigationTabController(title: "Profile", image: UIImage(systemName: "theatermask.and.paintbrush"), rootViewController: profileController)
        
        viewControllers = [latest, random, profile]
        
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        floatingButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        floatingButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -65).isActive = true
        floatingButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        floatingButton.layer.cornerRadius = 56 / 2
    }
    
    // MARK: - Actions
    @objc private func handleFloatingButton() {
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

@available(iOS 17.0, *)
#Preview {
    return MainTabController()
}
