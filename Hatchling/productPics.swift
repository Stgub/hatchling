//
//  productPics.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class productPics: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var logoPicImgAdd: UIImageView!
    @IBOutlet weak var prodPicImgAddOut: UIImageView!
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var imagePicker: UIImagePickerController!
    var imagePicker2: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        imagePicker2 = UIImagePickerController()
        imagePicker2.allowsEditing = true
        imagePicker2.delegate = self
    }
    
    //For product image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            prodPicImgAddOut.image = image
        } else {
            print("Steven: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
        imagePicker2.dismiss(animated: true, completion: nil)
    }
    
    //For logo image
    func imagePickerControllerLogo(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            logoPicImgAdd.image = image
        } else {
            print("Steven: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
        imagePicker2.dismiss(animated: true, completion: nil)
    }

    @IBAction func addProductImgTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func addLogoImgTapped(_ sender: Any) {
        present(imagePicker2, animated: true, completion: nil)
    }

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
