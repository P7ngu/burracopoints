//
//  CustomKeyboard.swift
//  burracopoints
//
//  Created by Matteo Perotta on 01/03/24.
//

import Foundation
import SwiftUI
import UIKit

struct CustomKeyboardTextField: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomKeyboardTextField
        
        init(_ textField: CustomKeyboardTextField) {
            self.parent = textField
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        let customKeyboard = CustomKeyboardView(targetTextField: textField)
        textField.inputView = customKeyboard // Use the custom keyboard as input view
        textField.text = text
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}


class CustomKeyboardView: UIInputView {
    weak var targetTextField: UITextField? // Reference to the text field to update
    
    init(targetTextField: UITextField?) {
        self.targetTextField = targetTextField
        super.init(frame: .zero, inputViewStyle: .keyboard)
        self.autoresizingMask = .flexibleHeight
        configureKeys()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureKeys() {
        // Configure your keyboard keys here
        let button = UIButton(type: .system)
        button.setTitle("1", for: .normal)
        button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        addSubview(button)
        
        // Layout your buttons as needed
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc private func keyPressed(_ sender: UIButton) {
        guard let key = sender.titleLabel?.text, let textField = targetTextField else { return }
        textField.insertText(key)
    }
}
