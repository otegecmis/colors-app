import Firebase

struct Color {
    
    // MARK: - Properties
    let uid: String
    let hex: String
    let username: String
    let userUID: String
    let timestamp: Timestamp
    
    // MARK: - Initializers
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.hex = dictionary["hex"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.userUID = dictionary["userUID"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
    // MARK: - Helpers
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "hex": hex,
            "username": username,
            "userUID": userUID,
            "timestamp": timestamp
        ]
    }
}
