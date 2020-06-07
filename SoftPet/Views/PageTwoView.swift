//
//  PageTwoView.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 31/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import UIKit

class PageTwoView: UIView {
    
    var tot: [PageModel]?
    var secMo: [SectionModel]?
    var eleMo: [ElementModel]?
    var ruleMo: [RuleModel]?
    
    
    var pageThreeAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let defaults = UserDefaults.standard
        if let savedForm = defaults.object(forKey: "saved_formmodel") as? Data {
            let decoder = JSONDecoder()
            if let loadedForm = try? decoder.decode(FormModel.self, from: savedForm) {
                print("kudi",loadedForm.name)
                tot = loadedForm.pages
                secMo = tot?[1].sections
                eleMo = secMo?[0].elements
            }
        }
      
        basicInfoLabel.text = secMo?[0].label
        yardLabel.text = eleMo?[0].label
        fencedLabel.text = eleMo?[1].label
        fencedLabel.font = UIFont.systemFont(ofSize: 12)
        yardQuestionSwitch.accessibilityIdentifier = "yesno_1"
        fencedTextField.accessibilityIdentifier = "text_3"
         
        setup()
    }
    
    func setup() {
        
        let stackV = pageTwoStackView()
        
        addSubview(stackV)
        backgroundColor = .white
        
        stackV.setAnchor(width: self.frame.width - 40, height: 250)
        stackV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    let basicInfoLabel: UILabel = {
        let bilb = UILabel()
        bilb.setAnchor(width: 0, height: 40)
        return bilb
    }()
    
    let yardLabel: UILabel = {
       let bilb = UILabel()
       bilb.setAnchor(width: 0, height: 40)
       return bilb
    }()
        
    let noLabel: UILabel = {
        let bilb = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "No", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), .foregroundColor: UIColor.darkGray]))
        bilb.attributedText = attributedString
        bilb.setAnchor(width: 0, height: 40)
        return bilb
    }()
        
    let yardQuestionSwitch: UISwitch = {
        let bilb = UISwitch()
        bilb.addTarget(self, action: #selector(switchYard), for: .valueChanged)
        bilb.setAnchor(width: 0, height: 40)
        return bilb
    }()
       
        
    let yesLabel: UILabel = {
        let bilb = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Yes", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), .foregroundColor: UIColor.darkGray]))
        bilb.attributedText = attributedString
        bilb.setAnchor(width: 0, height: 40)
        return bilb
    }()
      
    func horiStack() -> UIStackView {
        let stackV = UIStackView(arrangedSubviews: [yardLabel,noLabel, yardQuestionSwitch, yesLabel])

        stackV.axis = .horizontal
        stackV.distribution = .fillProportionally
        stackV.spacing = 20
      
        return stackV
    }
  
    let fencedLabel: UILabel = {
        let bilb = UILabel()
        bilb.isHidden = true
        bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        bilb.setAnchor(width: 0, height: 30)
       
        return bilb
    }()
    let fencedTextField: UITextField = {
        let ftf = UITextField()
        ftf.borderStyle = .none
        ftf.layer.cornerRadius = 5
        ftf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        ftf.textColor = UIColor.darkGray
        ftf.font = UIFont.systemFont(ofSize: 17)
        ftf.autocorrectionType = .no
        ftf.isHidden = true
        ftf.setAnchor(width: 0, height: 40)
        return ftf
    }()
        
    let nextButton: UIButton = {
        let nxtBtn = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "NEXT", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        nxtBtn.setAttributedTitle(attributedString, for: .normal)
        nxtBtn.layer.cornerRadius = 5
        nxtBtn.backgroundColor = .blue
        nxtBtn.setAnchor(width: 0, height: 60)
        nxtBtn.addTarget(self, action: #selector(goToPageThree), for: .touchUpInside)
        return nxtBtn
    }()
        
    func pageTwoStackView() -> UIStackView {
        let stackV = UIStackView(arrangedSubviews: [basicInfoLabel, horiStack(), fencedLabel, fencedTextField, nextButton])
        stackV.axis = .vertical
        stackV.distribution = .fillProportionally
        stackV.spacing = 20
        stackV.setCustomSpacing(0.0, after: fencedLabel)
        return stackV
    }
        
    @objc func goToPageThree(){
       pageThreeAction?()
    }

    @objc func switchYard(){
        let kini: [ElementModel]? = eleMo
        
        kini?.forEach { word in
            if(word.uniqueId == yardQuestionSwitch.accessibilityIdentifier){
                if yardQuestionSwitch.isOn  {
                    fencedLabel.isHidden = false
                    fencedTextField.isHidden = false
                 
                } else {
                    fencedLabel.isHidden = true
                    fencedTextField.isHidden = true
          
                }
            }
        }
 
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
