//
//  BirthdateViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 24.11.2024.
//

import UIKit

class BirthdateViewController: UIViewController {
    
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var birthdateTextfield: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var userInfo = UserInfo() // Veri modeli
    var keyboardViewModel: KeyboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        keyboardViewModel = KeyboardViewModel(viewController: self)
        keyboardViewModel.addTapGestureToDismissKeyboard()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(changeDate(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        
        birthdateTextfield.inputView = datePicker
        birthdateTextfield.text = dateFormat(date: Date())
        
        setupUI()
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    func setupUI() {
        birthdateLabel.text = "Doğum tarihinizi seçiniz."
        birthdateLabel.font = UIFont(name: K.Fonts.poppinsMedium, size: 22)
        button.setTitle("Devam et", for: .normal)
        button.backgroundColor = UIColor(named: K.BrandColors.darkModeBlack)
        button.tintColor = UIColor(named: K.BrandColors.darkModeWhite)
        button.layer.cornerRadius = 20
    }
    
    
    @objc func changeDate(datePicker: UIDatePicker) {
        birthdateTextfield.text = dateFormat(date: datePicker.date)
    }
    
    func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        // Soyad bilgisini alıyoruz
        guard let birthdate = birthdateTextfield.text, !birthdate.isEmpty else {
            showAlert(message: "Doğum gününüzü giriniz.")
            return
        }
        
        // Soyadı kullanıcı bilgilerine ekliyoruz
        userInfo.birthDate = birthdate
        let birthdateVC = ChildStatusViewController()
        birthdateVC.userInfo = userInfo
        navigationController?.pushViewController(birthdateVC, animated: true)
        
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
}
