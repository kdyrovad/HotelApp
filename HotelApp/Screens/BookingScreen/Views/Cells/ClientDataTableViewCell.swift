//
//  ClientDataTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//

import UIKit
import SnapKit
import AGInputControls

class ClientDataTableViewCell: UITableViewCell {
    
    var successTappedClosure: (() -> Void)?

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setUpViews()
        NotificationCenter.default.addObserver(self, selector: #selector(checking), name: NSNotification.Name("PayButtonPressed"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy  var phoneView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(hexString: "#F6F6F9")
        vieww.layer.cornerRadius = 10
        return vieww
    }()
    
    private lazy var phoneTextField: PhoneTextField = {
        let codeField = PhoneTextField()
        codeField.placeholder = "Номер телефона"
        codeField.formattingMask = "+7 (###) ###-##-##"
        codeField.backgroundColor = .clear
        codeField.delegate = self
        return codeField
    }()
    
    private var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 12)
        placeholderLabel.textColor = .gray
        placeholderLabel.alpha = 0.5
        placeholderLabel.isHidden = true
        return placeholderLabel
    }()
    
    private lazy var emailTextField: BasicTextField = {
        let textField = BasicTextField(placeholder: "Почта")
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = UIColor(hexString: "#F6F6F9")
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private var emailPlaceholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 12)
        placeholderLabel.textColor = .gray
        placeholderLabel.alpha = 0.5
        placeholderLabel.isHidden = true
        return placeholderLabel
    }()
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.text = "Информация о покупателе"
        
        return label
    }()
    
    private lazy var userDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
        label.font = UIFont(name: "SF Pro Display", size: 14)
        label.textColor = UIColor(hexString: "#828796")
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        placeholderLabel.text = phoneTextField.placeholder
        emailPlaceholderLabel.text = emailTextField.placeholder
        phoneTextField.layer.cornerRadius = 50
        
        phoneView.addSubview(phoneTextField)
        [introLabel, phoneView, placeholderLabel, emailTextField, emailPlaceholderLabel, userDataLabel].forEach {
            contentView.addSubview($0)
        }
        setConstraints()
    }
    
    private func isValid() -> Bool {
        var valid = true
        [emailTextField, phoneTextField].forEach {
            if ($0.text ?? "").isEmpty {
                showAlert(for: [$0])
                valid = false
            } else if ($0 is PhoneTextField) {
                alertReset(for: [phoneView])
            } else if ($0 is BasicTextField) {
                alertReset(for: [$0])
            }
        }
        
        if !valid { return false }
        
        if !validateEmail(string: emailTextField.text ?? "") {
            showAlert(for: [emailTextField])
            return false
        }
        
        if validateEmail(string: emailTextField.text ?? "") {
            alertReset(for: [emailTextField])
        }
        
        
        
        return true
    }
    
    private func validateEmail(string: String) -> Bool {
        let emailFormat = "[а-яА-Я\\s]+"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    @objc private func checking() {
        if isValid() {
            successTappedClosure?()
        }
    }
}

//MARK: - Constraints

extension ClientDataTableViewCell {
    private func setConstraints() {
        
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
        }
        
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(52)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.leading.equalTo(phoneView).offset(16)
            make.centerY.equalTo(phoneView.snp.centerY)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(phoneView).offset(8)
            make.centerY.equalTo(phoneView.snp.top).offset(10)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneView.snp.bottom).offset(8)
            make.leading.equalTo(phoneView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.height.equalTo(52)
        }
        
        emailPlaceholderLabel.snp.makeConstraints { make in
            make.left.equalTo(emailTextField).offset(8)
            make.centerY.equalTo(emailTextField.snp.top).offset(10)
        }
        
        userDataLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
        }
    }
}


//MARK: - BasicTextField

class BasicTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.borderStyle = .roundedRect
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.placeholder = placeholder
        self.leftViewMode = .always
        self.backgroundColor = UIColor(hexString: "#F6F6F9")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITextFieldDelegate

extension ClientDataTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updatePlaceholder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePlaceholder()
    }
    
    private func updatePlaceholder() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            if let text = self.phoneTextField.text, !text.isEmpty {
                self.placeholderLabel.font = UIFont.systemFont(ofSize: 12)
                self.placeholderLabel.snp.updateConstraints { make in
                    make.centerY.equalTo(self.phoneView.snp.top).offset(10)
                }
                self.placeholderLabel.alpha = 0.7
                self.placeholderLabel.isHidden = false
            } else {
                self.placeholderLabel.font = UIFont.systemFont(ofSize: 14)
                self.placeholderLabel.snp.updateConstraints { make in
                    make.centerY.equalTo(self.phoneView.snp.top).offset(16)
                }
                self.placeholderLabel.alpha = 0.5
                self.placeholderLabel.isHidden = true
            }
            
            if let text = self.emailTextField.text, !text.isEmpty {
                self.emailPlaceholderLabel.font = UIFont.systemFont(ofSize: 12)
                self.emailPlaceholderLabel.snp.updateConstraints { make in
                    make.centerY.equalTo(self.emailTextField.snp.top).offset(10)
                }
                self.emailPlaceholderLabel.alpha = 0.7
                self.emailPlaceholderLabel.isHidden = false
            } else {
                self.emailPlaceholderLabel.font = UIFont.systemFont(ofSize: 14)
                self.emailPlaceholderLabel.snp.updateConstraints { make in
                    make.centerY.equalTo(self.emailTextField.snp.top).offset(16)
                }
                self.emailPlaceholderLabel.alpha = 0.5
                self.emailPlaceholderLabel.isHidden = true
            }
            self.contentView.layoutIfNeeded()
        }, completion: nil)
    }
}

//MARK: - Alert

extension ClientDataTableViewCell {
    
    func showAlert(for fields: [UITextField]) {
        for field in fields {
            if field is PhoneTextField {
                phoneView.backgroundColor = UIColor(hexString: "#EB5757").withAlphaComponent(0.15)
            } else {
                field.backgroundColor = UIColor(hexString: "#EB5757").withAlphaComponent(0.15)
            }
        }
    }
    
    func alertReset(for fields: [UIView]) {
        for field in fields {
            field.backgroundColor = UIColor(hexString: "#F6F6F9")
        }
    }
}

extension ClientDataTableViewCell: PayButtonTableViewCellDelegate {
    func didTapPayButton() {
        if isValid() {
            successTappedClosure?()
        }
    }
}
