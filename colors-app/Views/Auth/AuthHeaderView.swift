import UIKit

class AuthHeaderView: UIView {
    
    // MARK: - Properties
    enum CustomTextFieldType {
        case signup
        case signin
        case reset
    }
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Subtitle"
        return label
    }()
    
    // MARK: - Init
    init(title: String, subtitle: String, type: CustomTextFieldType) {
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.configureUI()
        self.configureIconImageView(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 90),
            self.logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 13),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func configureIconImageView(type: CustomTextFieldType) {
        switch type {
        case .signup:
            if let image = UIImage(systemName: "person.crop.circle.badge.plus") {
                let tintedImage = image.withRenderingMode(.alwaysOriginal)
                logoImageView.tintColor = UIColor.systemBrown
                logoImageView.image = tintedImage
            }
        case .signin:
            if let image = UIImage(systemName: "paintpalette") {
                logoImageView.image = image.withRenderingMode(.alwaysOriginal)
            }
        case .reset:
            if let image = UIImage(systemName: "key") {
                let tintedImage = image.withRenderingMode(.alwaysOriginal)
                logoImageView.tintColor = UIColor.systemBrown
                logoImageView.image = tintedImage
            }
        }
    }
}
