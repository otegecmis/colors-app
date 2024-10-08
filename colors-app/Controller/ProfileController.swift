import UIKit
import FirebaseAuth

class ProfileController: UIViewController {
    
    // MARK: - Properties
    var user: User?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        if let username = user?.username {
            navigationItem.title = "@\(username)"
        }
        
        let preferences = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(handlePreferences))
        navigationItem.rightBarButtonItem = preferences
    }
    
    func signOut(action: UIAlertAction) {
        do {
            try Auth.auth().signOut()
            
            let signInController = SignInController()
            signInController.delegate = self.tabBarController as? MainTabController
            
            let navigationController = UINavigationController(rootViewController: signInController)
            navigationController.modalPresentationStyle = .fullScreen
            
            self.present(navigationController, animated: true, completion: nil)
        } catch {
            self.presentAlertOnMainThread(title: "Error", message: "Something wrong.", buttonTitle: "Done")
            return
        }
    }
    
    // MARK: - Actions
    @objc func handlePreferences() {
        let alertController = UIAlertController(title: "Preferences", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: signOut))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }
}
