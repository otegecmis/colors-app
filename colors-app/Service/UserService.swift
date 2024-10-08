import UIKit
import Firebase

struct UserService {
    
    // MARK: - Helpers
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            
            completion(user)
        }
    }
}
