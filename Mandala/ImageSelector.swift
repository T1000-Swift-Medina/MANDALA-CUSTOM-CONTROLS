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
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierachy()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewHierachy()
    }
    
    var selectedIndex = 0
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
                imageButton.adjustsImageSizeForAccessibilityContentSizeCategory = false
                imageButton.addTarget(self,
                                      action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
                return imageButton
            })
            selectedIndex = 0
        }
    }
    
    @objc private func imageButtonTapped(_ sender: UIButton){
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("The buttons and images are not parallel")
        }
        selectedIndex = buttonIndex
        sendActions(for: .valueChanged)
    }
    
}
