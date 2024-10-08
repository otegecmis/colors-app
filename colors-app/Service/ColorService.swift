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
        
        userRef.updateData(["colors": FieldValue.arrayUnion([color.toDictionary()])]) { error in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
    
    static func fetchColors(completion: @escaping([Color]?, Error?) -> Void) {
        COLLECTION_COLORS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion([], nil)
                return
            }
            
            let colors = documents.map { doc -> Color in
                let data = doc.data()
                return Color(dictionary: data)
            }
            
            completion(colors, nil)
        }
    }
    
    static func fetchColors(forUserUID userUID: String, completion: @escaping([Color]?, Error?) -> Void) {
        COLLECTION_COLORS.whereField("userUID", isEqualTo: userUID)
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion([], nil)
                    return
                }
                
                let colors = documents.map { doc -> Color in
                    let data = doc.data()
                    return Color(dictionary: data)
                }
                
                completion(colors, nil)
            }
    }
    
    static func fetchRandomColor(completion: @escaping(Color?, Error?) -> Void) {
        COLLECTION_COLORS.getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                completion(nil, nil)
                return
            }
            
            let randomIndex = Int.random(in: 0..<documents.count)
            let randomDocument = documents[randomIndex]
            let randomColor = Color(dictionary: randomDocument.data())
            
            completion(randomColor, nil)
        }
    }
    
    static func deleteColor(color: Color, completion: @escaping(Error?) -> Void) {
        let colorRef = COLLECTION_COLORS.document(color.uid)
        let userRef = COLLECTION_USERS.document(color.userUID)
        
        colorRef.delete { error in
            if let error = error {
                completion(error)
                return
            }
            
            userRef.updateData(["colors": FieldValue.arrayRemove([color.toDictionary()])]) { error in
                if let error = error {
                    completion(error)
                    return
                }
                
                completion(nil)
            }
        }
    }
}
