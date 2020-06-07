//
//  ViewController.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 30/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import UIKit

class PageOneController: UIViewController {

    var pageOneView: PageOneView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      // getting the processed json file saved in user default
        let defaults = UserDefaults.standard
        if let savedForm = defaults.object(forKey: "saved_formmodel") as? Data {
            let decoder = JSONDecoder()
            if let loadedForm = try? decoder.decode(FormModel.self, from: savedForm) {
                print("kudi",loadedForm.name)
                self.title = loadedForm.name
            }
        }
        
         self.navigationItem.setHidesBackButton(true, animated: true);
     
        view.backgroundColor = .blue
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
                setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .blue
        self.addKeyboardObserver()

    }
    
    func setupView(){
        let firstView = PageOneView(frame: self.view.frame)
        self.pageOneView = firstView
        self.pageOneView.pageTwoAction = nextPressed
        self.view.addSubview(pageOneView)
        pageOneView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
    }
    
  
    // handling the action that happens when the NEXT button is pressed in the view of this controlle
    func nextPressed(){
        
        guard let fname = pageOneView.fullNameLabel.text else {
            return
        }
        guard let email = pageOneView.emailTextField.text else {
            return
        }
        guard let phone = pageOneView.phoneTextField.text else {
            return
        }
        guard let dob = pageOneView.dobTextField.text else {
            return
        }
        
        if(fname.isEmpty || email.isEmpty || phone.isEmpty || dob.isEmpty){
            let alertController = UIAlertController(title: "", message:
                "All fields are required", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            print("Empty Barrel")
        } else {
//            print("zaza", pageOneView.phoneTextField.accessibilityIdentifier ?? "")
                    let pageTwoController = PageTwoController()
                    self.navigationController?.pushViewController(pageTwoController, animated: true)
        }
 
    }
    
    

   override func viewWillDisappear(_ animated: Bool) {
       self.removeKeyboardObserver()
   }

}

