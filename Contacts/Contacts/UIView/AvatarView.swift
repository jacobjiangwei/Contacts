//
//  AvatarView.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/22/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    private var imageView:UIImageView = UIImageView(frame: CGRect.zero)
    
    private var imageViewleadingAnchor:NSLayoutConstraint?
    private var imageViewtrailAnchor:NSLayoutConstraint?
    private var imageViewtopAnchor:NSLayoutConstraint?
    private var imageViewbottomAnchor:NSLayoutConstraint?
    static let borderColor = UIColor(red: 173.0/255.0, green: 216.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    fileprivate func _init() {
        accessibilityIdentifier = "avatarView"
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = UIColor.clear
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = "thumbnailImageView"
        imageView.layer.cornerRadius = frame.width / 2.0
        addSubview(imageView)
        
        imageViewleadingAnchor = imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0)
        imageViewtopAnchor = imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0)
        imageViewtrailAnchor = imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0)
        imageViewbottomAnchor = imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        
        imageViewleadingAnchor?.isActive = true
        imageViewtopAnchor?.isActive = true
        imageViewtrailAnchor?.isActive = true
        imageViewbottomAnchor?.isActive = true
    }
        
    
    var image:UIImage! {
        didSet {
            self.imageView.image = image
            self.isFocus = false
        }
    }
    
    var isFocus:Bool = false {
        didSet {
            if isFocus {
                imageView.layer.borderColor = AvatarView.borderColor
                imageView.layer.borderWidth = 3.0
                imageView.layer.cornerRadius = (frame.width + 3.0) / 2.0

                UIView.animate(withDuration: 0.3) {
                    self.imageViewleadingAnchor?.constant = -3.0
                    self.imageViewtopAnchor?.constant = -3.0
                    self.imageViewtrailAnchor?.constant = 3.0
                    self.imageViewbottomAnchor?.constant = 3.0
                }
            }
            else {
                imageView.layer.cornerRadius = frame.width / 2.0
                imageView.layer.borderColor = UIColor.clear.cgColor
                imageView.layer.borderWidth = 0.0
                UIView.animate(withDuration: 0.3) {
                    self.imageViewtopAnchor?.constant = 0.0
                    self.imageViewtrailAnchor?.constant = 0.0
                    self.imageViewbottomAnchor?.constant = 0.0
                    self.imageViewleadingAnchor?.constant = 0.0
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = frame.width / 2.0
    }
}
