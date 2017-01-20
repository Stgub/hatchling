//
//  productPics.swift
//  Hatchling
//
//  Created by Steven Graf on 1/19/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class productPics: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var imagePicked:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productImagePicker.delegate = self

        
        
        let pictureTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickProductPictureTapped(_:)))
        productPicture.isUserInteractionEnabled = true
        productPicture.addGestureRecognizer(pictureTap)

        let logoTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pickLogoPictureTapped(_:)))
        logoPicture.isUserInteractionEnabled = true
        logoPicture.addGestureRecognizer(logoTap)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var productPicture: UIImageView!
    @IBOutlet weak var logoPicture: UIImageView!

    let productImagePicker = UIImagePickerController()

    @IBAction func pickLogoPictureTapped(_ sender: Any) {
        print("picking Logo Picture")
        imagePicked = logoPicture
        productImagePicker.allowsEditing = true
        
        present(productImagePicker, animated: true, completion: nil)
        
    }

    @IBAction func pickProductPictureTapped(_ sender: Any) {
        print("picking Product Picture")
         imagePicked = productPicture
        productImagePicker.allowsEditing = true
        
        present(productImagePicker, animated: true, completion: nil)
    }

    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        imagePicked.contentMode = .scaleAspectFit //3
       imagePicked.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
