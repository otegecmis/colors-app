import FirebaseAuth

// MARK: - Credentials
struct AuthCredentials {
    let name: String
    let username: String
    let email: String
    let password: String
}

// MARK: - AuthService
struct AuthService {
    
    // MARK: - Helpers
    static func signIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
