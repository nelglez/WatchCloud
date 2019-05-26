//
//  AddCategoryVC.swift
//  WatchCloudAdmin
//
//  Created by Bogdan Dovgopol on 16/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddEditCategoryVC: UIViewController {

    //Outlets
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: UIButton!
    
    //Variables
    var categoryToEdit: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSettings()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        tap.numberOfTapsRequired = 1
        categoryImg.isUserInteractionEnabled = true
        categoryImg.addGestureRecognizer(tap)
        
        //If we are editing categoryToEdit will != nil
        if let category = categoryToEdit {
            debugPrint(category.name)
            
            nameTxt.text = category.name
            addBtn.setTitle("Save Changes", for: .normal)
            if let url = URL(string: category.imgUrl) {
                categoryImg.contentMode = .scaleAspectFill
                categoryImg.kf.setImage(with: url)
            }
        }
    }
    
    func navBarSettings() {
        self.navigationItem.title = "Add Category"
    }
    
    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImagePicker()
    }
    
    @IBAction func addCategoryClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        uploadImageThenDocument()
    }
    
    func uploadImageThenDocument() {
        
        guard let image = categoryImg.image,
            let categoryName = nameTxt.text, categoryName.isNotEmpty else {
                simpleAlert(title: "Error", message: "Must add category and name")
                return
        }
        
        
        // Turn image into Data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // Create an storage image reference -> A location in firestorage for it to be stored
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        
        //Set the meta data
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //Upload the data
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            
            if let error = error {
                self.handleError(error: error, message: "Unable to upload image.")
                return
            }
            
            //Once the image is uploaded, retrieve the download url
            imageRef.downloadURL(completion: { (url, error) in
                
                if let error = error {
                    self.handleError(error: error, message: "Unable to retrieve image url.")
                    return
                }
                
                guard let url = url else { return }
                
                //Upload new Category document to the firestore categories collection
                self.uploadDocument(url: url.absoluteString)
                
            })
            
        }
    }
    
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var category = Category.init(name: nameTxt.text!,
                                     id: "",
                                     imgUrl: url,
                                     timestamp: Timestamp())
        
        if let categoryToEdit = categoryToEdit {
            // we are edditing
            docRef = Firestore.firestore().collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            // new category
            docRef = Firestore.firestore().collection("categories").document()
            category.id = docRef.documentID
        }
        
        category.id = docRef.documentID
        
        let data = Category.modelToData(category: category)
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, message: "Unable to upload new category.")
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func handleError(error: Error, message: String) {
        debugPrint(error.localizedDescription)
        self.simpleAlert(title: "Error", message: message)
        self.activityIndicator.stopAnimating()
    }
    
}

extension AddEditCategoryVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        categoryImg.contentMode = .scaleAspectFill
        categoryImg.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
