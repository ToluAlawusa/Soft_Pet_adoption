//
//  PageThreeView.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 31/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import UIKit

class PageThreeView: UIView, UITextFieldDelegate {
    
    var tot: [PageModel]?
    var secMo: [SectionModel]?
    var eleMo: [ElementModel]?

    
    var submitAction: (() -> Void)?
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        let defaults = UserDefaults.standard
        if let savedForm = defaults.object(forKey: "saved_formmodel") as? Data {
            let decoder = JSONDecoder()
            if let loadedForm = try? decoder.decode(FormModel.self, from: savedForm) {
                
                tot = loadedForm.pages
                secMo = tot?[2].sections
                eleMo = secMo?[0].elements
                
            }
        }
        
        basicInfoLabel.text = secMo![0].label
        vetNameLabel.text = eleMo![0].label
        vetNameLabel.font = UIFont.systemFont(ofSize: 12)
        persRefLabel.text = eleMo![1].label
        persRefLabel.font = UIFont.systemFont(ofSize: 12)
        
        vetNameTextField.textContentType = .none
        persRefTextField.textContentType = .none
        
        vetNameTextField.accessibilityIdentifier = eleMo![0].uniqueId
        persRefTextField.accessibilityIdentifier = eleMo![1].uniqueId
        
        vetNameTextField.delegate = self
        persRefTextField.delegate = self
        
        
        setup()
    }

    func setup() {

        let stackV = pageThreeStackView()

        addSubview(stackV)
        backgroundColor = .white

        stackV.setAnchor(width: self.frame.width - 40, height: 300)
        stackV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    let basicInfoLabel: UILabel = {
        let bilb = UILabel()
        bilb.setAnchor(width: 0, height: 40)
        return bilb
    }()
    //
    let vetNameLabel: UILabel = {
            let bilb = UILabel()
            bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
            bilb.setAnchor(width: 0, height: 30)
       
        return bilb
    }()
    let vetNameTextField: UITextField = {
        let ftf = UITextField()
        
        ftf.borderStyle = .none
        ftf.layer.cornerRadius = 5
        ftf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        ftf.textColor = UIColor.darkGray
        ftf.font = UIFont.systemFont(ofSize: 17)
        ftf.autocorrectionType = .no
        ftf.setAnchor(width: 0, height: 40)
        return ftf
    }()
    
    let persRefLabel: UILabel = {
        let bilb = UILabel()
        bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        bilb.setAnchor(width: 0, height: 30)
        return bilb
    }()
    let persRefTextField: UITextField = {
        let ftf = UITextField()
        ftf.borderStyle = .none
        ftf.layer.cornerRadius = 5
        ftf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        ftf.textColor = UIColor.darkGray
        ftf.font = UIFont.systemFont(ofSize: 17)
        ftf.autocorrectionType = .no
        ftf.setAnchor(width: 0, height: 40)
        return ftf
      
    }()
            
    let nextButton: UIButton = {
        let nxtBtn = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "SUBMIT", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        nxtBtn.setAttributedTitle(attributedString, for: .normal)
        nxtBtn.layer.cornerRadius = 5
        nxtBtn.backgroundColor = .blue
        nxtBtn.setAnchor(width: 0, height: 50)
        nxtBtn.addTarget(self, action: #selector(doSubmit), for: .touchUpInside)
        return nxtBtn
    }()
            
    func pageThreeStackView() -> UIStackView {
        let stackV = UIStackView(arrangedSubviews: [basicInfoLabel, vetNameLabel, vetNameTextField, persRefLabel, persRefTextField, nextButton])
        stackV.axis = .vertical
        stackV.distribution = .fillProportionally
        stackV.spacing = 20
        stackV.setCustomSpacing(0.0, after: vetNameLabel)
        stackV.setCustomSpacing(0.0, after: persRefLabel)
        return stackV
    }
    
    @objc func doSubmit(){
       submitAction?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //to hide the keyboard
        //call any of your functions
       print("return ooo")
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
