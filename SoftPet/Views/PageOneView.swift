//
//  PageOneView.swift
//  SoftPet
//
//  Created by Tolulope Alawusa on 30/05/2020.
//  Copyright © 2020 Tolulope Alawusa. All rights reserved.
//

import UIKit
import Foundation

class PageOneView: UIView, UITextFieldDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
     var datepicker: UIDatePicker?
     var pageTwoAction: (() -> Void)?
     var tot: [PageModel]?
     var secMo: [SectionModel]?
     var imgElemo: [ElementModel]?
     var eleMo: [ElementModel]?
     var ski: Bool?
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       let defaults = UserDefaults.standard
       if let savedForm = defaults.object(forKey: "saved_formmodel") as? Data {
           let decoder = JSONDecoder()
           if let loadedForm = try? decoder.decode(FormModel.self, from: savedForm) {
               print("kudi",loadedForm.name)
               tot = loadedForm.pages
               secMo = tot?[0].sections
               imgElemo = secMo?[0].elements
               eleMo = secMo?[1].elements
               
           }
       }
      
       
       
        welcomeLabel.text = secMo?[0].label
        
        // Create URL
        let url = URL(string: imgElemo?[0].file ?? "")
        pageOneImage.downloadImage(from: url!)
        
        basicInfoLabel.text = secMo?[1].label
        fullNameLabel.text = eleMo?[0].label
        fullNameLabel.font = UIFont.systemFont(ofSize: 12)
        emailLabel.text = eleMo?[1].label
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        phoneLabel.text = eleMo?[2].label
        phoneLabel.font = UIFont.systemFont(ofSize: 12)
        dobLabel.text = eleMo?[3].label
        dobLabel.font = UIFont.systemFont(ofSize: 12)
        
        fullnameTextField.keyboardType = .default
        emailTextField.textContentType = .emailAddress
        phoneTextField.keyboardType = .numberPad
        phoneTextField.placeholder = eleMo?[2].formattedNumeric
        phoneTextField.doneAccessory = true
        dobTextField.keyboardType = .default
        
        fullnameTextField.accessibilityIdentifier = eleMo?[0].uniqueId
        emailTextField.accessibilityIdentifier = eleMo?[1].uniqueId
        phoneTextField.accessibilityIdentifier = eleMo?[2].uniqueId
        dobTextField.accessibilityIdentifier = eleMo?[3].uniqueId
        
        
        setup()
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        dobTextField.delegate = self
        datepicker = UIDatePicker()
        datepicker?.datePickerMode = .date
       
        datepicker?.addTarget(self, action: #selector(PageOneView.dateChanged(datePicker:)), for: .valueChanged)
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PageOneView.viewTapped(gestureRecognizer:)))
       
        self.addGestureRecognizer(tapGesture)
       
        dobTextField.inputView = datepicker
    }
    
    func setup() {
        
        let stackV = pageOneStackView()
        
        addSubview(stackV)
        backgroundColor = .white
        
        stackV.setAnchor(width: self.frame.width - 40, height: 700)
        stackV.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
       
    }
    
    
    let welcomeLabel: UILabel = {
        let wlb = UILabel()
        wlb.setAnchor(width: 0, height: 40)
        return wlb
    }()
    
    let pageOneImage: UIImageView = {
        let img = UIImageView()
        let imageName = "default_img.png"
        img.image = UIImage(named: imageName)
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        img.backgroundColor = .lightGray
        return img
    }()
    
    
    let basicInfoLabel: UILabel = {
        let bilb = UILabel()
        bilb.setAnchor(width: 0, height: 40)
        return bilb
        }()
    
    let fullNameLabel: UILabel = {
        let bilb = UILabel()
        bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        bilb.setAnchor(width: 0, height: 30)
       
        return bilb
    }()
    let fullnameTextField: UITextField = {
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
    
    let emailLabel: UILabel = {
        let bilb = UILabel()
        bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        bilb.setAnchor(width: 0, height: 30)
       
        return bilb
    }()
    
    let emailTextField: UITextField = {
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
    
    let phoneLabel: UILabel = {
        let bilb = UILabel()
        bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        bilb.setAnchor(width: 0, height: 30)
       
        return bilb
    }()
    let phoneTextField: UITextField = {
        let ftf = UITextField()
        ftf.borderStyle = .none
        ftf.layer.cornerRadius = 5
        ftf.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        ftf.textColor = UIColor.darkGray
        ftf.font = UIFont.systemFont(ofSize: 17)
        ftf.autocorrectionType = .no
        
        ftf.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        ftf.setAnchor(width: 0, height: 40)
        return ftf
        
        
    }()
    
    let dobLabel: UILabel = {
        let bilb = UILabel()
        bilb.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        bilb.setAnchor(width: 0, height: 30)
       
        return bilb
    }()
    let dobTextField: UITextField = {
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
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "NEXT", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        nxtBtn.setAttributedTitle(attributedString, for: .normal)
        nxtBtn.layer.cornerRadius = 5
        nxtBtn.backgroundColor = .blue
        nxtBtn.setAnchor(width: 0, height: 60)
        nxtBtn.addTarget(self, action: #selector(goToPageTwo), for: .touchUpInside)
        
        return nxtBtn
    }()
    
    func pageOneStackView() -> UIStackView {
        let stackV = UIStackView(arrangedSubviews: [welcomeLabel,pageOneImage,basicInfoLabel,fullNameLabel,  fullnameTextField,emailLabel,emailTextField,phoneLabel,phoneTextField,dobLabel,dobTextField, nextButton])
        
        stackV.axis = .vertical
        stackV.distribution = .fillProportionally
        stackV.spacing = 20
        stackV.setCustomSpacing(0.0, after: fullNameLabel)
        stackV.setCustomSpacing(0.0, after: emailLabel)
        stackV.setCustomSpacing(0.0, after: phoneLabel)
        stackV.setCustomSpacing(0.0, after: dobLabel)
        
        return stackV
    }
    
    @objc func goToPageTwo(){
       pageTwoAction?()
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        self.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dobTextField.text = dateFormatter.string(from: datePicker.date)
        self.endEditing(true)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() //to hide the keyboard
        //call any of your functions
       print("return ooo")
        return true
    }
    
    @objc private func editingChanged(sender: UITextField) {
        
            if let text = sender.text, text.count == 4 {
                sender.text = String(text+"-")
            }
        
            if let text = sender.text, text.count == 8 {
                sender.text = String(text+"-")
            }
        
            if let text = sender.text, text.count >= 13 {
                sender.text = String(text.dropLast(text.count - 13))
                return
            }
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}



