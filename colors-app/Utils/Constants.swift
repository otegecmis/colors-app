import Firebase

// MARK: - Firebase Collections
let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_COLORS = Firestore.firestore().collection("colors")

// MARK: - Mock Variables
let MOCK_COLORS: [UIColor] = [
    .red, .blue, .green, .yellow, .purple, .orange, .brown, .magenta, .cyan, .blue, .green, .yellow, .purple, .orange, .brown, .magenta, .cyan, .blue, .green, .yellow, .purple, .orange, .brown, .magenta, .cyan, .blue, .green, .yellow, .purple, .orange, .brown, .magenta, .cyan, .magenta, .cyan
]
