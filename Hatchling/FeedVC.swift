//
//  FeedVC.swift
//  Hatchling
//
//  Created by Charles Fayal on 1/14/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var swipeCardView: swipeCardShadowRoundCorner!
    var originalCenter:CGPoint!
    
     var posts:[Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalCenter = swipeCardView.center
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(FeedVC.wasDragged(_:)))
        swipeCardView.addGestureRecognizer(swipeGesture)

        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            print(snapshot.value)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                } 
                
            }
            //RELOAD DATA i.e. self.tableview.reloadData()
            
        })        // Do any additional setup after loading the view.
    }

    
    @IBAction func signOutBtnTapped(_ sender: Any) {
       
        try! FIRAuth.auth()!.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "intialVC") 
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    
    
    
    //MARK: - Gestures
    func wasDragged(_ gesture: UIPanGestureRecognizer)
    {
        let translation = gesture.translation(in: self.view)
        let view = gesture.view!
        //print("\(view.subviews.first?.frame)")
        view.center = CGPoint(x: swipeCardView.center.x + translation.x, y: self.swipeCardView.center.y + translation.y) // relative to bottom left of screen
        let xFromCenter = view.center.x - self.view.bounds.width/2
        let scale = 1000 / (abs(xFromCenter) + 1000 )
        var rotation = CGAffineTransform(rotationAngle: 0)
        var stretch = rotation.scaledBy(x: scale, y: scale)
        view.transform = stretch
        //Below decides if it is a left or right drag
        if gesture.state == UIGestureRecognizerState.ended {
            if view.center.x < 100 {
                print("left drag - next profile")
            } else if view.center.x > self.view.bounds.width - 100 {
                print("right drag - previous profile")
            }
            //Returns the view back to normal
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            view.transform = stretch
            view.center  = originalCenter
        }
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
