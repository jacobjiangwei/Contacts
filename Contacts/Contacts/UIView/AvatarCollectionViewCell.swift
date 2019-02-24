//
//  AvatarCollectionViewCell.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/22/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
    var avatarView:AvatarView = AvatarView(frame: CGRect.zero)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.accessibilityIdentifier = "avatarCollectionViewCell"
        addSubview(avatarView)
        
        avatarView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: frame.width/1.2).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: frame.width/1.2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
