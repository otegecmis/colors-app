import UIKit
import FirebaseAuth

class ProfileController: UIViewController {
    
    // MARK: - Properties
    var user: User?
    
    private let colorGridView = ColorGrid()
    private let refreshControl = UIRefreshControl()
    
    private var colors: [UIColor] = MOCK_COLORS
        
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        if let username = user?.username {
            navigationItem.title = "@\(username)"
        }
        
        let preferences = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(handlePreferences))
        navigationItem.rightBarButtonItem = preferences
    }
    
    func configureUI() {
        view.addSubview(colorGridView)
        
        colorGridView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorGridView.topAnchor.constraint(equalTo: view.topAnchor),
            colorGridView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorGridView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorGridView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        colorGridView.setDataSource(self)
        colorGridView.setDelegate(self)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        colorGridView.collectionView.refreshControl = refreshControl
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
    
    @objc private func handleRefresh() {
        colors.shuffle()
        colorGridView.configure(with: colors)
        
        refreshControl.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ProfileController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        
        cell.applyRoundedCorners(radius: 5)
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
}
