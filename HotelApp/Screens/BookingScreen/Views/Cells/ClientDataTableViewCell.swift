//
//  ClientDataTableViewCell.swift
//  HotelApp
//
//  Created by Дильяра Кдырова on 21.12.2023.
//

import UIKit
import SnapKit

class ClientDataTableViewCell: UITableViewCell {

    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy var phoneTextField: BasicTextField = {
        let textField = BasicTextField(placeholder: "Hомер телефона")
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.text = "+7"
        return textField
    }()
    
    private var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 12)
        placeholderLabel.textColor = .gray
        placeholderLabel.alpha = 0.5
        placeholderLabel.isHidden = true
        return placeholderLabel
    }()
    
//    private lazy var emailTextField: BasicTextField = {
//        let textField = BasicTextField(placeholder: "Почта")
//        textField.delegate = self
//        textField.isUserInteractionEnabled = true
//        return textField
//    }()
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SF Pro Display", size: 22)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.text = "Информация о покупателе"
        
        return label
    }()
    
    //MARK: - Methods
    
    private func setUpViews() {
        placeholderLabel.text = phoneTextField.placeholder
        [introLabel, phoneTextField, placeholderLabel].forEach {
            contentView.addSubview($0)
        }
        setConstraints()
    }
}

//MARK: - Constraints

extension ClientDataTableViewCell {
    private func setConstraints() {
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(introLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(48)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(phoneTextField).offset(8)
            make.centerY.equalTo(phoneTextField.snp.top).offset(16)
        }
    }
}


//MARK: - BasicTextField

class BasicTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.borderStyle = .roundedRect
        self.font = .boldSystemFont(ofSize: 14)
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
                self.placeholderLabel.font = UIFont.systemFont(ofSize: 10)
                self.placeholderLabel.snp.updateConstraints { make in
                    make.centerY.equalTo(self.phoneTextField.snp.top).offset(8)
                }
                self.placeholderLabel.alpha = 0.7
                self.placeholderLabel.isHidden = false
            } else {
                self.placeholderLabel.font = UIFont.systemFont(ofSize: 14)
                self.placeholderLabel.snp.updateConstraints { make in
                    make.centerY.equalTo(self.phoneTextField.snp.top).offset(16)
                }
                self.placeholderLabel.alpha = 0.5
                self.placeholderLabel.isHidden = true
            }
            self.contentView.layoutIfNeeded()
        }, completion: nil)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else {
//            return true
//        }
//
//        let newString = (text as NSString).replacingCharacters(in: range, with: string)
//        let formattedString = formatPhoneNumber(newString)
//
//        textField.text = formattedString
//
//        return false
//    }
//
//    private func formatPhoneNumber(_ number: String) -> String {
//        let digits = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
//
//        var formattedNumber = "+7"
//
//        let areaCodeLength = min(digits.count, 3)
//        if areaCodeLength > 0 {
//            let areaCode = digits.prefix(areaCodeLength)
//            formattedNumber += " (\(areaCode))"
//        }
//
//        let remainingDigits = digits.suffix(from: digits.index(digits.startIndex, offsetBy: areaCodeLength))
//
//        if remainingDigits.count > 0 {
//            formattedNumber += " \(remainingDigits.prefix(2))"
//        }
//
//        if remainingDigits.count > 2 {
//            formattedNumber += "-\(remainingDigits.suffix(from: remainingDigits.index(remainingDigits.startIndex, offsetBy: 2)))"
//        }
//
//        return formattedNumber
//    }



    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case phoneTextField:
            phoneTextField.text = setPhoneNumberMask(textField: phoneTextField, mask: "+7 (XXX) XX-XX", string: string, range: range)
        default:
            break
        }
        return false
    }

    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""

        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex

        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }

        return result
    }
}


//MARK: - For PhoneMask

//public protocol AGFormatter {
//    var mask: String { get }
//    var maskHasConstantPrefix: Bool { get }
//    var prefix: String { get }
//    var allowsEmptyOrNilStrings: Bool { get }
//    var acceptedLetters: Set<Character> { get }
//
//    func formattedText(text: String?) -> String?
//    func isNumberOrLetter(_ ch: Character?) -> Bool
//    func isValidString(text: String?) -> Bool
//}
//
//public struct PhoneNumberFormatter: AGFormatter {
//
//    public let mask: String
//
//    public var prefix: String {
//        guard let separator = mask.first(
//            where: { !($0.isNumber || $0 == "+" || $0 == "#") }
//        ) else {
//            return ""
//        }
//
//        return mask.components(separatedBy: String(separator)).first ?? ""
//    }
//
//    public init(mask: String) {
//        self.mask = mask
//    }
//
//    public func formattedText(text: String?) -> String? {
//        guard var t = text?.trimmingCharacters(in: .whitespacesAndNewlines),
//              t != "+",
//              !t.isEmpty
//        else { return "" }
//
//        if t == prefix && maskHasConstantPrefix {
//            return nil
//        }
//
//        // Special case for Russian numbers. if we paste number in old format (e.g 89997776655) we conver it in international format (replace 8 with +7)
//        if prefix == "+7" && (t.first == "8" || t.first == "7") && t.count >= 11 {
//            t = prefix + t.dropFirst()
//        }
//
//        if maskHasConstantPrefix && !t.hasPrefix(prefix) {
//            t = prefix + t
//        }
//
//        let formatted = t.formattedNumber(mask: mask)
//
//        return formatted
//    }
//}
