//
//  AddEditProductVC.swift
//  WatchCloudAdmin
//
//  Created by Bogdan Dovgopol on 16/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddEditProductVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var productPriceTxt: UITextField!
    @IBOutlet weak var productDescriptionTxt: UITextView!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: RoundedButton!
    
    
    //Variables
    var selectedCategory: Category!
    var productToEdit: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSettings()
        
        //add tap gesture on product img view
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        tap.numberOfTapsRequired = 1
        productImgView.isUserInteractionEnabled = true
        productImgView.addGestureRecognizer(tap)
        
        //If we are editing productToEdit will != nil
        if let product = productToEdit {
            productNameTxt.text = product.name
            productPriceTxt.text = String(product.price)
            productDescriptionTxt.text = product.productDescription
            addBtn.setTitle("Save Changes", for: .normal)
            if let url = URL(string: product.imgUrl) {
                productImgView.contentMode = .scaleAspectFill
                productImgView.kf.setImage(with: url)
            }
        }

    }
    
    func navBarSettings() {
        self.navigationItem.title = "Add Product"
    }
    
    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImagePicker()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        activityIndicator.startAnimating()
        uploadImageThenDocument()
    }
    
    func uploadImageThenDocument() {
        
        guard let image = productImgView.image,
            let name = productNameTxt.text, name.isNotEmpty,
            let price = productPriceTxt.text, price.isNotEmpty,
            let description = productDescriptionTxt.text, description.isNotEmpty
        else {
                simpleAlert(title: "Error", message: "Must fill all the fields")
                return
        }
        
        
        // Turn image into Data
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        // Create an storage image reference -> A location in firestorage for it to be stored
        let imageRef = Storage.storage().reference().child("/productImages/\(name).jpg")
        
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
        var product = Product.init(id: "", name: productNameTxt.text!, price: productPriceTxt.text!.toDouble, productDescription: productDescriptionTxt.text!, category: selectedCategory.id, imgUrl: url, timestamp: Timestamp())
        
        if let productToEdit = productToEdit {
            // we are edditing
            docRef = Firestore.firestore().collection("products").document(productToEdit.id)
            product.id = productToEdit.id
        } else {
            // new category
            docRef = Firestore.firestore().collection("products").document()
            product.id = docRef.documentID
        }
        
        product.id = docRef.documentID
        
        let data = Product.modelToData(product: product)
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

extension AddEditProductVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        productImgView.contentMode = .scaleAspectFill
        productImgView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
