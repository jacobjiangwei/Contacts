//
//  AuthorTableViewCell.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/23/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {

    fileprivate var nameLabel:UILabel = UILabel()
    fileprivate var titleLabel:UILabel = UILabel()
    fileprivate var aboutMeLabel:UILabel = UILabel()
    fileprivate var introductionLabel:UILabel = UILabel()
    
    
    fileprivate let firstFont = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    fileprivate let lastFont = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        presetLabel(label: nameLabel)
        presetLabel(label: titleLabel)
        presetLabel(label: aboutMeLabel)
        presetLabel(label: introductionLabel)
        
        nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 20.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5.0).isActive = true
        aboutMeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0).isActive = true
        introductionLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 5.0).isActive = true
        introductionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20.0).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: UIScreen.main.bounds.height - collectionViewHeight - 44.0).isActive = true
        
        nameLabel.textColor = UIColor.black
        titleLabel.textColor = UIColor.gray
        aboutMeLabel.textColor = UIColor.black
        introductionLabel.textColor = UIColor.gray
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        aboutMeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        introductionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        nameLabel.textAlignment = .center
        titleLabel.textAlignment = .center
        aboutMeLabel.textAlignment = .left
        introductionLabel.textAlignment = .left
        introductionLabel.numberOfLines = 0
        
        aboutMeLabel.text = NSLocalizedString("About Me", comment: "About Me")
    }
    
    private func presetLabel(label:UILabel) {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 20.0).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -20.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setData(contact:Contact) {
        let firstNameAttributes = [NSAttributedString.Key.font:firstFont,
                          NSAttributedString.Key.foregroundColor:UIColor.black]
        let lastNameAttributes = [NSAttributedString.Key.font:lastFont,
                                  NSAttributedString.Key.foregroundColor:UIColor.gray]
        let combineStr = contact.first_name! + " " + contact.last_name!
        let firstRange = NSRange(location: 0, length: contact.first_name?.count ?? 0)
        let lastRange = NSRange(location: 1 + (contact.first_name?.count ?? 0), length: contact.last_name?.count ?? 0)
        let attrStr = NSMutableAttributedString(string: combineStr)
        attrStr.addAttributes(firstNameAttributes, range: firstRange)
        attrStr.addAttributes(lastNameAttributes, range: lastRange)
        
        self.nameLabel.attributedText = attrStr
        self.titleLabel.text = contact.title
        self.introductionLabel.text = contact.introduction
    }

}
