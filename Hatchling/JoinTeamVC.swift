//
//  joinTeamVC.swift
//  Hatchling
//
//  Created by Steven Graf on 2/7/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import MessageUI

class JoinTeamVC: UIViewController, MFMailComposeViewControllerDelegate, hasPostVar{
    var post:Post!
    @IBOutlet weak var messageField: textViewRoundCorners!
    
    @IBAction func backBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedSubmitBtn(_ sender: Any) {
        guard let person = currentUser.name else {
            print("CHUCK: No current user name")
            return
        }
        let subject = "\(person) interested in position with your company"
        guard let message = messageField.text else {
            presentUIAlert(sender: self, title: "No message", message: "Please add a message before submitting")
            return
        }
        let recepients = [self.post.email]
        sendEmail(subject: subject, message: message, recepients: recepients)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        if !MFMailComposeViewController.canSendMail() {
            print("Chuck: mail services are not available")
            presentUIAlert(sender: self, title: "Mail Service Does Not Work", message: "Please try again later", action: self.dismiss(animated: true, completion: nil))
            return
            
        }
    }
    // MARK: - Email Delegate
    
    func mailComposeController(controller: MFMailComposeViewController,
        didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

    func sendEmail(subject: String, message:String, recepients:[String]){
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(recepients)
        composeVC.setSubject(subject)
        composeVC.setMessageBody(message, isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
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
