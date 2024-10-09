import UIKit

class LatestController: UIViewController {
    
    // MARK: - Properties
    private let colorGridView = ColorGrid()
    private let refreshControl = UIRefreshControl()
    
    private var colors: [UIColor] = MOCK_COLORS.shuffled()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
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
        colors.shuffle()
        colorGridView.configure(with: colors)
        
        refreshControl.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension LatestController: UICollectionViewDataSource, UICollectionViewDelegate {
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
