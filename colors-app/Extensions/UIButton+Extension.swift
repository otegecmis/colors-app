import UIKit

extension UIButton {
    
    // MARK: - Helpers
    func attributedTitle(firstPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    func attributedTitle(firstPart: String, secondPart: String) {
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "\(firstPart) ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.label, .font: UIFont.boldSystemFont(ofSize: 16)]
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
