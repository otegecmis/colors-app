import UIKit

class LatestController: UIViewController {
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Latest"
    }
}