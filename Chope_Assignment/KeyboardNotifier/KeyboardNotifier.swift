//
//  KeyboardNotifier.swift
//  Chope_Assignment
//
//  Created by Rahul Swayana on 10/12/21.
//

import Foundation
import UIKit

protocol KeyBoardNotifierDelegate: class {
    func didKeyBoardAppeared(keyboardHeight: CGFloat)
}

class KeyboardNotifier: NSObject {
    // MARK: - Variables & Constants

    weak var keyboarddelegate: KeyBoardNotifierDelegate?
    
    // MARK: - SharedInstance

    static let shared = KeyboardNotifier()
    
    // MARK: - Public Methods
    
    func registerforKeyBoardNotification(delegate: UIViewController) {
        keyboarddelegate = delegate as? KeyBoardNotifierDelegate
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard Delegates
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        if let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 0.5) {
                self.keyboarddelegate?.didKeyBoardAppeared(keyboardHeight: keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.keyboarddelegate?.didKeyBoardAppeared(keyboardHeight: 0)
        }
    }
}
