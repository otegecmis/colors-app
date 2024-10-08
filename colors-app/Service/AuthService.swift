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
    
    static func signUp(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let data: [String: Any] = [
                "uid": uid,
                "name": credentials.name,
                "username": credentials.username,
                "email": credentials.email,
            ]
            
            COLLECTION_USERS.document(uid).setData(data, completion: completion)
        }
    }
    
    static func resetPassword(withEmail email: String, completion: ((Error?) -> Void)?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
