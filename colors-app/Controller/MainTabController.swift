import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        configureViewControllers()
        openLogoutMenu()
    }
    
    // MARK: - Helpers
    func configureViewControllers() {
        view.backgroundColor = .systemBackground
        
        let latest = navigationTabController(title: "Latest", image: UIImage(systemName: "paintpalette"), rootViewController: LatestController())
        let create = navigationTabController(title: "Create", image: UIImage(systemName: "paintbrush"), rootViewController: CreateController())
        let random = navigationTabController(title: "Random", image: UIImage(systemName: "swatchpalette"), rootViewController: RandomController())
        let profile = navigationTabController(title: "Profile", image: UIImage(systemName: "theatermask.and.paintbrush"), rootViewController: ProfileController())
        
        viewControllers = [latest, create, random, profile]
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: SignInController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func openLogoutMenu() {
        if let profileTabBarItemView = self.tabBar.items?[3].value(forKey: "view") as? UIView {
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLogoutMenu))
            profileTabBarItemView.addGestureRecognizer(longPressGesture)
        }
    }
    
    func logout(action: UIAlertAction) {
        presentAlertOnMainThread(title: "Warning", message: "Logout is not implemented yet.", buttonTitle: "Done")
        return
    }
    
    // MARK: - Actions
    @objc func handleLogoutMenu(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let alertController = UIAlertController(title: "Name Surname - @username", message: nil, preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: logout))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            present(alertController, animated: true)
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    return MainTabController()
}
