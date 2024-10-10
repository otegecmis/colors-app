import UIKit

final class LatestController: UIViewController {
    
    // MARK: - Properties
    private let colorGridView = ColorGrid()
    private let refreshControl = UIRefreshControl()
    
    private var colors: [Color] = []
    
    var user: User?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchColors()
        configureViewController()
        configureUI()
    }
    
    // MARK: - Service
    func fetchColors() {
        ColorService.fetchColors { colors, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            
            if let colors = colors {
                self.colors = colors
                DispatchQueue.main.async {
                    self.colorGridView.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Helpers
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title =  "Latest"
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
    
    // MARK: - Actions
    @objc private func handleRefresh() {
        fetchColors()
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension LatestController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        
        cell.applyRoundedCorners(radius: 5)
        cell.backgroundColor = UIColor(hex: colors[indexPath.item].hex)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LatestController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorViewController = ColorViewController()
        
        colorViewController.color = colors[indexPath.item]
        colorViewController.user = user
        
        navigationController?.pushViewController(colorViewController, animated: true)
    }
}
