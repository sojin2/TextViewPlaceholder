//
//  ViewController.swift
//  TextViewPlaceholder
//
//  Created by 김소진 on 2023/07/26.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.text = "메세지를 입력하세요"
        $0.textColor = UIColor.lightGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        setup()
    }

    func setup() {
        view.backgroundColor = .white
        view.addSubview(textView)

        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 10, bottom: 50, right: 10))
        }
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        textView.contentInset.bottom = keyboardFrame.size.height
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        textView.contentInset = contentInset
    }
}
