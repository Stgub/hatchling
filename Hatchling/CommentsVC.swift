//
//  CommentsVC.swift
//  Hatchling
//
//  Created by Steven Graf on 2/2/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController, UITextViewDelegate {
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Keyboard shows
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveTextView(textView: textView, moveDistance: -250, up: true)
    }
    
    // Keyboard hidden
    func  textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(textView: textView, moveDistance: -250, up: false)
    }
    //Keyboard movement
    func moveTextView(textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
