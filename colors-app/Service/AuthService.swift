import FirebaseAuth

struct AuthCredentials {
    let name: String
    let username: String
    let email: String
    let password: String
}

struct AuthService {
    
    // MARK: - Helpers
    static func signIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
