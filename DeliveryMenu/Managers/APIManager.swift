//
//  APIManager.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 6.11.22.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    static let shared = APIManager()
    
// MARK: -
// MARK: - Private Methods
    
    private func configureFirebase() -> Firestore {
        // для хранения разных типов данных
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }

// MARK: -
// MARK: - Public Methods
    
    func setUserData(currentUser: UserModel) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
    
        let dataBase = configureFirebase()
        dataBase.collection("Users").document(userUID).setData([
            "name" : currentUser.name,
            "email" : currentUser.email,
            "phone" : currentUser.phoneNumber
        ])
    }
    
    func getPost(collection: String, completion: @escaping ([Document]?) -> Void, failure: @escaping () -> Void) {
        let dataBase = configureFirebase()
        dataBase.collection(collection).getDocuments { result, error in
            guard let result else { return }
            
            if let error = error {
                print(error.localizedDescription)
                failure()
            } else {
                var arrayToReturn = [Document]()
                
                for doc in result.documents {
                    let data = doc.data()
                    guard let nameField = data["nameField"] as? String else { return }
                    guard let volumeFiled = data["volumeField"] as? String else { return }
                    guard let priceField = data["priceField"] as? String else { return }
                    guard let id = data["id"] as? String else { return }
                    let document = Document(nameField: nameField, volumeField: volumeFiled, priceField: priceField, dataFolderName: collection, imageFolderName: collection, imageName: doc.documentID, id: id)
                    arrayToReturn.append(document)
                }
                completion(arrayToReturn)
            }
        }
    }
    
    func getImageURL(folderName: String, picName: String, completion: @escaping (URL?) -> Void) {
        // инициализация хранилища для картинок
        let storage = Storage.storage()
        let reference = storage.reference()
        // ссылка для дирректории
        let pathReference = reference.child("pictures/" + "\(folderName)/")
        
        // создание ссылки для изображения
        let imageRef = pathReference.child(picName + ".png")
        imageRef.downloadURL { url, error in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(url)
        }
    }
    
}
