//
//  CreateProductDetails.swift
//  Hatchling
//
//  Created by Steven Graf on 1/18/17.
//  Copyright © 2017 IdeaShare. All rights reserved.
//

import UIKit

class CreateProductDetails: UIViewController {
    
    @IBAction func backBtnATapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //Labels
    @IBOutlet weak var prodStageLabel: UILabel!
    @IBOutlet weak var prodCategoriesLabel: UILabel!
    @IBOutlet weak var prodTalentLabel: UILabel!
    
    
    //Option Backgrounds
    @IBOutlet weak var stageBackImg: UIImageView!
    @IBOutlet weak var categoriesBackImg: UIImageView!
    @IBOutlet weak var needsBackImg: UIImageView!

    //Option Buttons Outlet and Action
        //Stage
    @IBOutlet weak var ideationBtnOutlet: UIButton!
    @IBAction func ideationBtn(_ sender: Any) {
        prodStageLabel.text = "ideation"
    }
    @IBOutlet weak var validationBtnOut: UIButton!
    @IBAction func validationBtn(_ sender: Any) {
        prodStageLabel.text = "validation"
    }
    @IBOutlet weak var fundraisingBtnOut: UIButton!
    @IBAction func fundraisingBtn(_ sender: Any) {
    }
    @IBOutlet weak var developmentBtnOut: UIButton!
    @IBAction func developmentBtn(_ sender: Any) {
        prodStageLabel.text = "development"
    }
    @IBOutlet weak var iterationBtnOut: UIButton!
    @IBAction func iterationBtn(_ sender: Any) {
        prodStageLabel.text = "iteration"
    }
    @IBOutlet weak var launchBtnOut: UIButton!
    @IBAction func launchBtn(_ sender: Any) {
        prodStageLabel.text = "launch"
    }
    @IBOutlet weak var stageXBtnOut: UIButton!
        //Categories
    @IBOutlet weak var fashionBtnOut: UIButton!
    @IBAction func fashionBtn(_ sender: Any) {
        prodCategoriesLabel.text = "fashion"
    }
    @IBOutlet weak var artBtnOut: UIButton!
    @IBAction func artBtn(_ sender: Any) {
        prodCategoriesLabel.text = "art"
    }
    @IBOutlet weak var outdoorBtnOut: UIButton!
    @IBAction func outdoorBtn(_ sender: Any) {
        prodCategoriesLabel.text = "outdoor"
    }
    @IBOutlet weak var gamesBtnOut: UIButton!
    @IBAction func gamesBtn(_ sender: Any) {
        prodCategoriesLabel.text = "games"
    }
    @IBOutlet weak var filmBtnOut: UIButton!
    @IBAction func filmBtn(_ sender: Any) {
        prodCategoriesLabel.text = "film"
    }
    @IBOutlet weak var foodBtnOut: UIButton!
    @IBAction func foodBtn(_ sender: Any) {
        prodCategoriesLabel.text = "food"
    }
    @IBOutlet weak var musicBtnOut: UIButton!
    @IBAction func musicBtn(_ sender: Any) {
        prodCategoriesLabel.text = "music"
    }
    @IBOutlet weak var techBtnOut: UIButton!
    @IBAction func techBtn(_ sender: Any) {
        prodCategoriesLabel.text = "tech"
    }
    @IBOutlet weak var designBtnOut: UIButton!
    @IBAction func designBtn(_ sender: Any) {
        prodCategoriesLabel.text = "design"
    }
    @IBOutlet weak var categoriesXBtnOut: UIButton!
        //Needs
    @IBOutlet weak var clearBtnOut: UIButton!
    @IBAction func clearBtn(_ sender: Any) {
        prodTalentLabel.text = ""
    }
    @IBOutlet weak var salesBtnOut: UIButton!
    @IBAction func salesBtn(_ sender: Any) {
        prodTalentLabel.text = "sales"
    }
    @IBOutlet weak var financeBtnOut: UIButton!
    @IBAction func financeBtn(_ sender: Any) {
        prodTalentLabel.text = "finance"
    }
    @IBOutlet weak var marketingBtnOut: UIButton!
    @IBAction func marketingBtn(_ sender: Any) {
        prodTalentLabel.text = "marketing"
    }
    @IBOutlet weak var fundraisingBtnOut1: UIButton!
    @IBAction func fundraisingBtn1(_ sender: Any) {
        prodTalentLabel.text = "fundraising"
    }
    @IBOutlet weak var entrepreneurBtnOut: UIButton!
    @IBAction func entrepreneurBtn(_ sender: Any) {
        prodTalentLabel.text = "entrepreneur"
    }
    @IBOutlet weak var needsXBtnOut: UIButton!


    
    
    
    //Choose buttons tapped and x buttons tapped
    @IBAction func ProdStageBtnTapped(_ sender: Any) {
        stageBackImg.isHidden = false
        ideationBtnOutlet.isHidden = false
        validationBtnOut.isHidden = false
        fundraisingBtnOut.isHidden = false
        developmentBtnOut.isHidden = false
        iterationBtnOut.isHidden = false
        launchBtnOut.isHidden = false
        stageXBtnOut.isHidden = false
    }
    @IBAction func stageXBtnTapped(_ sender: Any) {
        stageBackImg.isHidden = true
        ideationBtnOutlet.isHidden = true
        validationBtnOut.isHidden = true
        fundraisingBtnOut.isHidden = true
        developmentBtnOut.isHidden = true
        iterationBtnOut.isHidden = true
        launchBtnOut.isHidden = true
        stageXBtnOut.isHidden = true
    }
    @IBAction func prodCategoriesBtnTapped(_ sender: Any) {
        stageBackImg.isHidden = true
        ideationBtnOutlet.isHidden = true
        validationBtnOut.isHidden = true
        fundraisingBtnOut.isHidden = true
        developmentBtnOut.isHidden = true
        iterationBtnOut.isHidden = true
        launchBtnOut.isHidden = true
        stageXBtnOut.isHidden = true
        
        categoriesBackImg.isHidden = false
        fashionBtnOut.isHidden = false
        techBtnOut.isHidden = false
        designBtnOut.isHidden = false
        artBtnOut.isHidden = false
        foodBtnOut.isHidden = false
        musicBtnOut.isHidden = false
        outdoorBtnOut.isHidden = false
        gamesBtnOut.isHidden = false
        filmBtnOut.isHidden = false
        categoriesXBtnOut.isHidden = false
    }
    @IBAction func categoriesXBtnTapped(_ sender: Any) {
        categoriesBackImg.isHidden = true
        fashionBtnOut.isHidden = true
        techBtnOut.isHidden = true
        designBtnOut.isHidden = true
        artBtnOut.isHidden = true
        foodBtnOut.isHidden = true
        musicBtnOut.isHidden = true
        outdoorBtnOut.isHidden = true
        gamesBtnOut.isHidden = true
        filmBtnOut.isHidden = true
        categoriesXBtnOut.isHidden = true
    }
    @IBAction func needsBtnTapped(_ sender: Any) {
        categoriesBackImg.isHidden = true
        fashionBtnOut.isHidden = true
        techBtnOut.isHidden = true
        designBtnOut.isHidden = true
        artBtnOut.isHidden = true
        foodBtnOut.isHidden = true
        musicBtnOut.isHidden = true
        outdoorBtnOut.isHidden = true
        gamesBtnOut.isHidden = true
        filmBtnOut.isHidden = true
        categoriesXBtnOut.isHidden = true
        stageBackImg.isHidden = true
        ideationBtnOutlet.isHidden = true
        validationBtnOut.isHidden = true
        fundraisingBtnOut.isHidden = true
        developmentBtnOut.isHidden = true
        iterationBtnOut.isHidden = true
        launchBtnOut.isHidden = true
        stageXBtnOut.isHidden = true
        
        needsBackImg.isHidden = false
        fundraisingBtnOut1.isHidden = false
        financeBtnOut.isHidden = false
        marketingBtnOut.isHidden = false
        entrepreneurBtnOut.isHidden = false
        salesBtnOut.isHidden = false
        clearBtnOut.isHidden = false
        needsXBtnOut.isHidden = false
        
    }
    @IBAction func needsXBtnTapped(_ sender: Any) {
        needsBackImg.isHidden = true
        fundraisingBtnOut1.isHidden = true
        financeBtnOut.isHidden = true
        marketingBtnOut.isHidden = true
        entrepreneurBtnOut.isHidden = true
        salesBtnOut.isHidden = true
        clearBtnOut.isHidden = true
        needsXBtnOut.isHidden = true
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
