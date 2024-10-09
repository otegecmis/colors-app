import UIKit

class CButton: UIButton {
    
    // MARK: - Properties
    enum FontSize {
        case big
        case med
        case small
    }
    
    // MARK: - Initializers
    init(title: String, hasBackground: Bool = false, fontSize: FontSize = .med) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackground ? .label : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .label
        self.setTitleColor(titleColor, for: .normal)
        
        setSize(fontSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func setSize(fontSize: FontSize) {
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
}
