//
//  PageThreeController.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 31/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import UIKit

class PageThreeController: UIViewController {

    var pageThreeView: PageThreeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tot: [PageModel]?
        
        // getting the processed json file saved in user default
        let defaults = UserDefaults.standard
        if let savedForm = defaults.object(forKey: "saved_formmodel") as? Data {
            let decoder = JSONDecoder()
            if let loadedForm = try? decoder.decode(FormModel.self, from: savedForm) {
                tot = loadedForm.pages
               
            }
        }

        self.title = tot?[2].label
        setupView()
    }
    
    
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.navigationBar.barTintColor = .blue

   }
   
   func setupView(){
       let thirdView = PageThreeView(frame: self.view.frame)
       self.pageThreeView = thirdView
       self.pageThreeView.submitAction = nextPressed
       self.view.addSubview(pageThreeView)
       pageThreeView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
   }
   
    // handling the action that happens when the SUBMIT button is pressed in the view of this controller
   func nextPressed(){
    
    guard let personalRef = pageThreeView.persRefTextField.text else {
        return
    }
    
    if(personalRef.isEmpty){
        let alertController = UIAlertController(title: pageThreeView.persRefLabel.text, message:
            "field cannot be empty", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    } else {
        
        let alert = UIAlertController(title: "",
         message: "Thanks for Submitting",
         preferredStyle: .alert)
         
         let okay = UIAlertAction(title: "Ok", style: .default, handler: {_ in
             CATransaction.setCompletionBlock({
                let pageOneController = PageOneController()
                 self.navigationController?.pushViewController(pageOneController, animated: true)
                
             })
         })
         alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
        
        
       print("Submit")
    }
      
   }

}
