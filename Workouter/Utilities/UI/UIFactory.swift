//
//  UIView+Extension.swift
//  Workouter
//
//  Created by 이종현 on 2023/05/31.
//

import UIKit

final class UIFactory {
    
    private init() {}
    
    static func uiButtonWillReturned(title: String, fontSize: CGFloat? = nil, target: Any? = nil, action: Selector? = nil, tag: Int? = nil, backgroundColor background: UIColor = .opaqueSeparator) -> UIButton {
        let bt = UIButton(type: .system)
        bt.setTitle(title, for: .normal)
        if let fontSize {
            bt.titleLabel?.font = .systemFont(ofSize: fontSize)
        }
        bt.setTitleColor(.dynamicColor, for: .normal)
        bt.backgroundColor = background
        bt.layer.cornerRadius = 8
        bt.layer.masksToBounds = true
        if let target, let action {
            bt.addTarget(target, action: action, for: .touchUpInside)
        }
        if let tag {
            bt.tag = tag
        }
        return bt
    }
    
    static func uiImageButtonWillReturned(_ name: String, size: CGFloat? = nil, weight: UIImage.SymbolWeight? = nil, scale: UIImage.SymbolScale? = nil, target: Any? = nil, action a: Selector? = nil) -> UIButton {
        let bt = UIButton()
        var customConfig: UIImage.SymbolConfiguration = .unspecified
        if let size, let weight, let scale {
            customConfig = UIImage.SymbolConfiguration(pointSize: size,
                                                          weight: weight,
                                                          scale: scale)
        }
        let ellipsis = UIImage(systemName: name, withConfiguration: customConfig)
        bt.setImage(ellipsis, for: .normal)
        bt.tintColor = .dynamicColor
        if let target, let a {
            bt.addTarget(target, action: a, for: .touchUpInside)
        }
        return bt
    }

    static func uiTextFieldWillReturned(placeholder p: String? = nil, text t: String? = nil, tag: Int = 0, type: UIKeyboardType = .default) -> UITextField {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.placeholder = p
        tf.text = t
        tf.font = .systemFont(ofSize: 15, weight: .medium)
        tf.backgroundColor = .quaternarySystemFill
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        tf.layer.masksToBounds = true
        tf.tag = tag
        tf.keyboardType = type
        return tf
    }

    static func uiLabelWillReturned(title t: String, size: CGFloat = 15, weight: UIFont.Weight = .regular, alignment: NSTextAlignment = .natural) -> UILabel {
        let lb = UILabel()
        lb.text = t
        lb.font = .systemFont(ofSize: size, weight: weight)
        lb.textAlignment = alignment
        return lb
    }
    
    static func uiStackViewWillReturned(views vs: [UIView], alignment ali: UIStackView.Alignment = .center, axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 20, distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stv = UIStackView(arrangedSubviews: vs)
        stv.axis = axis
        stv.alignment = ali
        stv.spacing = spacing 
        stv.distribution = distribution
        return stv
    }

}
    

