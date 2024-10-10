import Firebase

struct ColorService {
    
    // MARK: - Helpers
    static func createColor(color: Color, completion: @escaping(Error?) -> Void) {
        let colorRef = COLLECTION_COLORS.document(color.uid)
        
        colorRef.setData(color.toDictionary()) { error in
            if let error = error {
                completion(error)
                return
            }
            
            addColorToUser(uid: color.userUID, color: color, completion: completion)
        }
    }
    
    private static func addColorToUser(uid: String, color: Color, completion: @escaping(Error?) -> Void) {
        let userRef = COLLECTION_USERS.document(uid)
        
        userRef.updateData([
            "colors": FieldValue.arrayUnion([color.toDictionary()])
        ]) { error in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
}
