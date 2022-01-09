//
//  ImageSelector.swift
//  Mandala
//
//  Created by Abdulaziz Alfayaa on 07/01/2022.
//

import UIKit

class ImageSelector: UIControl {

    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private func configureViewHierachy(){
        addSubview(selectorStackView)
        insertSubview(highlightView, belowSubview: selectorStackView)
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            highlightView.heightAnchor.constraint(equalTo: highlightView.widthAnchor),
            highlightView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            highlightView.centerYAnchor.constraint(equalTo: selectorStackView.centerYAnchor)
        ])
    }
    private var highlightViewXConstraint: NSLayoutConstraint! {
        didSet {
            oldValue?.isActive = false
            highlightViewXConstraint.isActive = true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierachy()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewHierachy()
    }
    
    var selectedIndex = 0 {
        didSet{
        if selectedIndex < 0 {
            selectedIndex = 0
        }
        if selectedIndex >= imageButtons.count {
            selectedIndex = imageButtons.count - 1
        }
        let imageButton = imageButtons[selectedIndex]
        highlightViewXConstraint = highlightView.centerXAnchor.constraint(equalTo: imageButton.centerXAnchor)
        imageButtons[oldValue].isHighlighted = true
        }
    }
    private var imageButtons: [UIButton] = [] {
        didSet {
            oldValue.forEach({$0.removeFromSuperview()})
            imageButtons.forEach({selectorStackView.addArrangedSubview($0)})
        }
    }
    var images: [UIImage] = [] {
        didSet {
            imageButtons = images.map({ image in
                let imageButton = UIButton()
                
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                // As per iOS 15
                // UIButton().adjustsImageWhenHighlighted is deprecated we will adjust button highlights by ourselves
                if #available(iOS 15, *) {
                    imageButton.isHighlighted = true
                } else {
                    imageButton.adjustsImageWhenHighlighted = false
                    imageButton.isHighlighted = true
                }
                imageButton.addTarget(self,
                                      action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
                return imageButton
            })
            selectedIndex = 0
            imageButtons[selectedIndex].isHighlighted = false
        }
    }
    private let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = view.tintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    @objc private func imageButtonTapped(_ sender: UIButton){
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("The buttons and images are not parallel")
        }
        selectedIndex = buttonIndex
        sendActions(for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        highlightView.layer.cornerRadius = highlightView.bounds.width / 2
    }
}
