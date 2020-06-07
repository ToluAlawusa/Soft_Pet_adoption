//
//  PageTwoController.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 31/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import UIKit

class PageTwoController: UIViewController {

    var pageTwoView: PageTwoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tot: [PageModel]?
        
         // getting the processed json file saved in user default
        let defaults = UserDefaults.standard
        if let savedForm = defaults.object(forKey: "saved_formmodel") as? Data {
            let decoder = JSONDecoder()
            if let loadedForm = try? decoder.decode(FormModel.self, from: savedForm) {
                tot = loadedForm.pages
                print("kudi",loadedForm.name)
            }
        }
  
        self.title = tot?[1].label
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .blue

    }
    
    func setupView(){
        let secondView = PageTwoView(frame: self.view.frame)
        self.pageTwoView = secondView
        self.pageTwoView.pageThreeAction = nextPressed
        self.view.addSubview(pageTwoView)
        pageTwoView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0)
    }
        
// handling the action that happens when the NEXT button is pressed in the view of this controller
    func nextPressed(){
        
        guard let theSwitch: Bool = pageTwoView.yardQuestionSwitch.isOn == true else {
            return
        }
        
        
        if (theSwitch == true){
        
            print("next pressed2")
            let pageThreeController = PageThreeController()
 
            self.navigationController?.pushViewController(pageThreeController, animated: true)
        } else {
            let alertController = UIAlertController(title: pageTwoView.yardLabel.text, message:
                "you must select yes", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
